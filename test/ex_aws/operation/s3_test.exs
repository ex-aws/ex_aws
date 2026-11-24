defmodule ExAws.Operation.S3Test do
  use ExUnit.Case, async: true
  import Mox

  alias Elixir.ExAws.Operation.ExAws.Operation.S3

  setup :verify_on_exit!

  @request_opts [
    access_key_id: "AKIAIOSFODNN7EXAMPLE",
    secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1",
    http_client: ExAws.Request.HttpMock
  ]

  def s3_operation(bucket \\ "my-bucket-1") do
    %ExAws.Operation.S3{
      body: "",
      bucket: bucket,
      headers: %{},
      http_method: :get,
      params: [],
      parser: & &1,
      path: "/folder",
      resource: "",
      service: :s3,
      stream_builder: nil
    }
  end

  test "S3 adds bucket to path when virtual_host is missing from config" do
    config = ExAws.Config.new(:s3)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == config.host)
    assert(processed_operation.path == "/#{operation.bucket}#{operation.path}")
  end

  test "S3 adds bucket to path when virtual_host is false" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, false)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == config.host)
    assert(processed_operation.path == "/#{operation.bucket}#{operation.path}")
  end

  test "S3 adds bucket to path when virtual_host is true" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "#{operation.bucket}.#{config.host}")
    assert(processed_operation.path == operation.path)
  end

  test "S3 raises when bucket is nil" do
    config = ExAws.Config.new(:s3)
    operation = s3_operation(nil)

    assert_raise RuntimeError,
                 "#{S3}.perform/2 cannot perform operation on `nil` bucket",
                 fn -> S3.add_bucket_to_path(operation, config) end
  end

  test "paths . and .. should *not* be normalised away" do
    config = ExAws.Config.new(:s3)
    operation = %{s3_operation() | path: "a/../b/../c/./d"}

    {processed_operation, _processed_config} = S3.add_bucket_to_path(operation, config)
    assert processed_operation.path == "/my-bucket-1/a/../b/../c/./d"
  end

  test "ensure paths ending with / preserve the trailing /" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, false)
    operation = %{s3_operation() | path: "folder/"}

    {processed_operation, _processed_config} = S3.add_bucket_to_path(operation, config)
    assert processed_operation.path == "/my-bucket-1/folder/"
  end

  test "ensure paths ending with / preserve the trailing / (virtual-host)" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)
    operation = %{s3_operation() | path: "folder/"}

    {processed_operation, _processed_config} = S3.add_bucket_to_path(operation, config)
    assert processed_operation.path == "/folder/"
  end

  test "S3 uses bucket as host when both virtual_host and bucket_as_host are true" do
    config =
      ExAws.Config.new(:s3) |> Map.put(:virtual_host, true) |> Map.put(:bucket_as_host, true)

    operation = s3_operation("my-custom-domain.com")

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "my-custom-domain.com")
    assert(processed_operation.path == "/folder")
  end

  test "S3 uses standard virtual host when virtual_host is true but bucket_as_host is false" do
    config =
      ExAws.Config.new(:s3) |> Map.put(:virtual_host, true) |> Map.put(:bucket_as_host, false)

    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "#{operation.bucket}.#{ExAws.Config.new(:s3).host}")
    assert(processed_operation.path == "/folder")
  end

  describe "bucket names used as the request host" do
    @malicious_bucket "attacker.example/x?"

    test "virtual_host rejects a bucket name that would change the request host" do
      config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)

      assert_raise ArgumentError, ~r/invalid bucket name/, fn ->
        S3.add_bucket_to_path(s3_operation(@malicious_bucket), config)
      end
    end

    test "bucket_as_host rejects a bucket name that is not a plain hostname" do
      config =
        ExAws.Config.new(:s3) |> Map.put(:virtual_host, true) |> Map.put(:bucket_as_host, true)

      assert_raise ArgumentError, ~r/invalid bucket name/, fn ->
        S3.add_bucket_to_path(s3_operation(@malicious_bucket), config)
      end
    end

    test "virtual_host rejects other URL delimiters, whitespace and empty bucket names" do
      config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)

      for bucket <- [
            "bucket?x",
            "bucket#x",
            "user@bucket",
            "bucket:443",
            "buck et",
            "bucket\n",
            ""
          ] do
        assert_raise ArgumentError, fn -> S3.add_bucket_to_path(s3_operation(bucket), config) end
      end
    end

    test "virtual_host still accepts dotted, dashed and legacy bucket names" do
      config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)

      for bucket <- ["my-bucket", "my.bucket.name", "Legacy_Bucket_1"] do
        {_operation, processed_config} = S3.add_bucket_to_path(s3_operation(bucket), config)
        assert processed_config.host == "#{bucket}.#{config.host}"
      end
    end

    test "virtual_host keeps a hostname-shaped bucket under the configured host" do
      config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)

      for bucket <- ["attacker.example", "169.254.169.254", "localhost"] do
        {_operation, processed_config} = S3.add_bucket_to_path(s3_operation(bucket), config)
        assert processed_config.host == "#{bucket}.#{config.host}"
      end
    end

    test "virtual_host accepts atom bucket names" do
      config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)

      {_operation, processed_config} = S3.add_bucket_to_path(s3_operation(:my_bucket), config)
      assert processed_config.host == "my_bucket.#{config.host}"

      assert_raise ArgumentError, ~r/invalid bucket name/, fn ->
        S3.add_bucket_to_path(s3_operation(:"attacker.example/x?"), config)
      end
    end

    test "bucket_as_host_allowlist rejects hosts that are not listed" do
      config =
        ExAws.Config.new(:s3)
        |> Map.put(:virtual_host, true)
        |> Map.put(:bucket_as_host, true)
        |> Map.put(:bucket_as_host_allowlist, ["assets.example.com"])

      for bucket <- [
            "attacker.example",
            "169.254.169.254",
            "localhost",
            "assets.example.com.attacker.example",
            "xassets.example.com"
          ] do
        assert_raise ArgumentError, ~r/bucket_as_host_allowlist/, fn ->
          S3.add_bucket_to_path(s3_operation(bucket), config)
        end
      end
    end

    test "bucket_as_host_allowlist accepts listed hosts, ignoring case" do
      config =
        ExAws.Config.new(:s3)
        |> Map.put(:virtual_host, true)
        |> Map.put(:bucket_as_host, true)
        |> Map.put(:bucket_as_host_allowlist, ["assets.example.com", "Media.Example.com"])

      for bucket <- ["assets.example.com", "ASSETS.example.com", "media.example.com"] do
        {_operation, processed_config} = S3.add_bucket_to_path(s3_operation(bucket), config)
        assert processed_config.host == bucket
      end
    end

    test "an empty bucket_as_host_allowlist rejects every bucket" do
      config =
        ExAws.Config.new(:s3)
        |> Map.put(:virtual_host, true)
        |> Map.put(:bucket_as_host, true)
        |> Map.put(:bucket_as_host_allowlist, [])

      assert_raise ArgumentError, ~r/bucket_as_host_allowlist/, fn ->
        S3.add_bucket_to_path(s3_operation("assets.example.com"), config)
      end
    end

    test "a bucket_as_host_allowlist that is not a list is rejected" do
      config =
        ExAws.Config.new(:s3)
        |> Map.put(:virtual_host, true)
        |> Map.put(:bucket_as_host, true)
        |> Map.put(:bucket_as_host_allowlist, "assets.example.com")

      assert_raise ArgumentError, ~r/expected a list of hostnames/, fn ->
        S3.add_bucket_to_path(s3_operation("assets.example.com"), config)
      end
    end

    test "bucket_as_host_allowlist set through ExAws.Config.new/2 is enforced" do
      config =
        ExAws.Config.new(:s3,
          virtual_host: true,
          bucket_as_host: true,
          bucket_as_host_allowlist: ["assets.example.com", "media.example.com"]
        )

      for bucket <- ["assets.example.com", "media.example.com"] do
        {_operation, processed_config} = S3.add_bucket_to_path(s3_operation(bucket), config)
        assert processed_config.host == bucket
      end

      assert_raise ArgumentError, ~r/is not in the configured/, fn ->
        S3.add_bucket_to_path(s3_operation("attacker.example"), config)
      end
    end

    test "an empty bucket_as_host_allowlist set through ExAws.Config.new/2 rejects every bucket" do
      config =
        ExAws.Config.new(:s3,
          virtual_host: true,
          bucket_as_host: true,
          bucket_as_host_allowlist: []
        )

      assert_raise ArgumentError, ~r/is not in the configured/, fn ->
        S3.add_bucket_to_path(s3_operation("assets.example.com"), config)
      end
    end

    test "bucket_as_host_allowlist does not apply without bucket_as_host" do
      config =
        ExAws.Config.new(:s3)
        |> Map.put(:virtual_host, true)
        |> Map.put(:bucket_as_host_allowlist, ["assets.example.com"])

      {_operation, processed_config} = S3.add_bucket_to_path(s3_operation("my-bucket"), config)
      assert processed_config.host == "my-bucket.#{config.host}"
    end

    test "path style requests do not use the hostname check" do
      config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, false)

      {processed_operation, processed_config} =
        S3.add_bucket_to_path(s3_operation("bucket/prefix"), config)

      assert processed_config.host == config.host
      assert processed_operation.path == "/bucket/prefix/folder"
    end
  end

  describe "perform/2 with reserved characters in the object key" do
    test "requests the percent-encoded key when it contains ?" do
      operation = %{s3_operation("victim-bucket") | path: "export.dump?.txt"}

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/export.dump%3F.txt"
    end

    test "does not let ? in the key inject an S3 sub-resource" do
      operation = %{s3_operation("victim-bucket") | path: "report.pdf?acl"}

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/report.pdf%3Facl"
    end

    test "keeps the key apart from the query string" do
      operation = %{
        s3_operation("victim-bucket")
        | path: "a?b.txt",
          params: %{"versionId" => "1"}
      }

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/a%3Fb.txt?versionId=1"
    end

    test "still encodes space, +, # and % in the key" do
      operation = %{s3_operation("victim-bucket") | path: "dir/a b+c#d%25.txt"}

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/dir/a%20b%2Bc%23d%2525.txt"
    end

    test "encodes the key with virtual host addressing" do
      operation = %{s3_operation("victim-bucket") | path: "export.dump?.txt"}

      assert requested_url(operation, virtual_host: true) ==
               "https://victim-bucket.s3.amazonaws.com/export.dump%3F.txt"
    end
  end

  # Performs the operation through the public ExAws.request/2 entry point and
  # returns the URL that reached the HTTP client.
  defp requested_url(operation, extra_opts \\ []) do
    test_pid = self()

    expect(ExAws.Request.HttpMock, :request, fn _method, url, _body, _headers, _opts ->
      send(test_pid, {:requested_url, url})
      {:ok, %{status_code: 200, body: "", headers: []}}
    end)

    assert {:ok, _} = ExAws.request(operation, @request_opts ++ extra_opts)
    assert_received {:requested_url, url}
    url
  end
end
