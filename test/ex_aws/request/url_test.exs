defmodule ExAws.Request.UrlTest do
  use ExUnit.Case, async: true
  alias ExAws.Request.Url

  describe "build" do
    setup do
      query = %{
        path: "/path",
        params: %{foo: :bar}
      }

      config = %{
        scheme: "https",
        host: "example.com",
        port: 443,
        normalize_path: true
      }

      {:ok, %{query: query, config: config}}
    end

    test "it build urls for query operation", %{query: query, config: config} do
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it allows setting custom port", %{query: query, config: config} do
      config = config |> Map.put(:port, 4430)
      assert Url.build(query, config) == "https://example.com:4430/path?foo=bar"
    end

    test "it converts the port to an integer if it is a string", %{query: query, config: config} do
      config = config |> Map.put(:port, "4430")
      assert Url.build(query, config) == "https://example.com:4430/path?foo=bar"
    end

    test "it allows passing scheme with trailing ://", %{query: query, config: config} do
      config = config |> Map.put(:scheme, "https://")
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it accepts params as a list of keywords", %{query: query, config: config} do
      query = query |> Map.put(:params, foo: :bar)
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it does not have trailing ? when params is an empty map", %{
      query: query,
      config: config
    } do
      query = query |> Map.put(:params, %{})
      assert Url.build(query, config) == "https://example.com/path"
    end

    test "it does not have trailing ? when params is an empty list", %{
      query: query,
      config: config
    } do
      query = query |> Map.put(:params, [])
      assert Url.build(query, config) == "https://example.com/path"
    end

    test "it accepts query without params key", %{query: query, config: config} do
      query = query |> Map.delete(:params)
      assert Url.build(query, config) == "https://example.com/path"
    end

    test "it cleans up excessive slashes in the path", %{query: query, config: config} do
      query = query |> Map.put(:path, "//path///with/too/many//slashes//")
      assert Url.build(query, config) == "https://example.com/path/with/too/many/slashes/?foo=bar"
    end

    test "it ignores empty parameter key", %{query: query, config: config} do
      query = query |> Map.put(:params, %{"foo" => "bar", "" => 1})
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it ignores nil parameter key", %{query: query, config: config} do
      query = query |> Map.put(:params, %{"foo" => "bar", nil => 1})
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it prepends base_path when set", %{query: query, config: config} do
      config = config |> Map.put(:base_path, "/minio")
      assert Url.build(query, config) == "https://example.com/minio/path?foo=bar"
    end

    test "it handles base_path with trailing slash", %{query: query, config: config} do
      config = config |> Map.put(:base_path, "/minio/")
      assert Url.build(query, config) == "https://example.com/minio/path?foo=bar"
    end

    test "it handles base_path when operation path has no leading slash", %{
      query: query,
      config: config
    } do
      query = query |> Map.put(:path, "path")
      config = config |> Map.put(:base_path, "/minio")
      assert Url.build(query, config) == "https://example.com/minio/path?foo=bar"
    end

    test "it does not change path when base_path is nil", %{query: query, config: config} do
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it does not change path when base_path is empty string", %{query: query, config: config} do
      config = config |> Map.put(:base_path, "")
      assert Url.build(query, config) == "https://example.com/path?foo=bar"
    end

    test "it handles base_path without leading slash", %{query: query, config: config} do
      config = config |> Map.put(:base_path, "minio")
      assert Url.build(query, config) == "https://example.com/minio/path?foo=bar"
    end

    test "it handles multi-segment base_path", %{query: query, config: config} do
      config = config |> Map.put(:base_path, "/minio/api/v1")
      assert Url.build(query, config) == "https://example.com/minio/api/v1/path?foo=bar"
    end

    test "it handles root operation path with base_path", %{query: query, config: config} do
      query = query |> Map.put(:path, "/") |> Map.put(:params, %{})
      config = config |> Map.put(:base_path, "/minio")
      assert Url.build(query, config) == "https://example.com/minio"
    end
  end

  describe "build for S3 operations" do
    setup do
      config = %{scheme: "https", host: "example.com", port: 443, normalize_path: true}
      {:ok, %{config: config}}
    end

    test "it percent-encodes reserved characters in the object key", %{config: config} do
      operation = s3_operation("/bucket/dir/a b+c#d%25.txt")

      assert Url.build(operation, config) ==
               "https://example.com/bucket/dir/a%20b%2Bc%23d%2525.txt"
    end

    test "it keeps a ? in the object key out of the query string", %{config: config} do
      operation = s3_operation("/bucket/export.dump?.txt")
      assert Url.build(operation, config) == "https://example.com/bucket/export.dump%3F.txt"
    end

    test "it does not let a ? in the object key inject a sub-resource", %{config: config} do
      operation = s3_operation("/bucket/report.pdf?acl")
      assert Url.build(operation, config) == "https://example.com/bucket/report.pdf%3Facl"
    end

    test "it keeps a ? in the object key apart from the real params", %{config: config} do
      operation = s3_operation("/bucket/a?b.txt", %{"versionId" => "1"})
      assert Url.build(operation, config) == "https://example.com/bucket/a%3Fb.txt?versionId=1"
    end

    test "it does not drop a trailing ? from the object key", %{config: config} do
      operation = s3_operation("/bucket/foo?")
      assert Url.build(operation, config) == "https://example.com/bucket/foo%3F"
    end

    test "it prepends base_path to the encoded object key", %{config: config} do
      config = config |> Map.put(:base_path, "/minio")
      operation = s3_operation("/bucket/a b.txt")
      assert Url.build(operation, config) == "https://example.com/minio/bucket/a%20b.txt"
    end

    test "it percent-encodes base_path as well", %{config: config} do
      config = config |> Map.put(:base_path, "/my base")
      operation = s3_operation("/bucket/a b.txt")
      assert Url.build(operation, config) == "https://example.com/my%20base/bucket/a%20b.txt"
    end

    test "it does not encode base_path for other services", %{config: config} do
      config = config |> Map.put(:base_path, "/my base")
      operation = %{path: "/functions/fn/invocations", service: :lambda}

      assert Url.build(operation, config) ==
               "https://example.com/my base/functions/fn/invocations"
    end

    test "it leaves the path of other services untouched", %{config: config} do
      operation = %{path: "/functions/arn:aws:lambda:fn/invocations", service: :lambda}

      assert Url.build(operation, config) ==
               "https://example.com/functions/arn:aws:lambda:fn/invocations"
    end
  end

  describe "get_path" do
    test "it uses S3-specific URL parsing to keep the path for S3 services" do
      url = "https://example.com/uploads/invalid path but+valid//for#s3/haha.txt"
      assert Url.get_path(url, :s3) == "/uploads/invalid path but+valid//for#s3/haha.txt"
    end

    test "it uses standard URL parsing for the path for non-S3 services" do
      url = "https://example.com/uploads/invalid path but+valid//for#i-am-anchor"
      assert Url.get_path(url) == "/uploads/invalid path but+valid//for"
    end

    test "returns an empty path when there isn't one specified in the url" do
      url = "https://example.com"
      assert Url.get_path(url) == "/"
    end
  end

  describe "sanitize" do
    setup do
      query = %ExAws.Operation.S3{
        body: "",
        bucket: "",
        headers: %{},
        http_method: :get,
        params: %{
          "marker" => "docs/MS FINCH+Paid_25_Oct_2017_16:54:15.pdf"
        },
        path: "/",
        resource: "",
        service: :s3
      }

      config = %{
        scheme: "https",
        host: "example.com",
        port: 443,
        normalize_path: true
      }

      {:ok, %{query: query, config: config}}
    end

    test "it build urls for query operation", %{query: query, config: config} do
      assert Url.build(query, config) |> Url.sanitize(query.service) ==
               "https://example.com/?marker=docs%2FMS%20FINCH%2BPaid_25_Oct_2017_16%3A54%3A15.pdf"
    end

    test "it does not split an object key containing ? into path and query", %{
      query: query,
      config: config
    } do
      query = %{query | path: "/bucket/export.dump?.txt", params: %{}}

      assert Url.build(query, config) |> Url.sanitize(query.service) ==
               "https://example.com/bucket/export.dump%3F.txt"
    end

    test "it does not re-encode the object key", %{query: query, config: config} do
      query = %{query | path: "/bucket/dir/a b+c#d%25.txt", params: %{"versionId" => "a b"}}

      assert Url.build(query, config) |> Url.sanitize(query.service) ==
               "https://example.com/bucket/dir/a%20b%2Bc%23d%2525.txt?versionId=a%20b"
    end
  end

  defp s3_operation(path, params \\ %{}) do
    %ExAws.Operation.S3{path: path, params: params}
  end
end
