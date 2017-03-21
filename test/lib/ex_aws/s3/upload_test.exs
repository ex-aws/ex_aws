defmodule ExAws.S3.UploadTest do
  use ExUnit.Case, async: true

  import Support.BypassHelpers
  alias ExAws.S3

  describe "integration test" do
    setup [:start_bypass]

    test "uploading a file with a stream", %{bypass: bypass} do
      file_path = __ENV__.file

      setup_multipart_upload_backend(bypass, self(), "my-bucket", "test.txt")

      {:ok, _} =
        file_path
        |> S3.Upload.stream_file
        |> S3.upload("my-bucket", "test.txt")
        |> ExAws.request(exaws_config_for_bypass(bypass))

      assert_received :initiated_upload
      assert_received :chunk_uploaded
      assert_received :completed_upload
    end
  end

  defp setup_multipart_upload_backend(bypass, test_pid, bucket_name, path) do
    request_path = "/#{bucket_name}/#{path}"
    upload_id = "a-very-secret-upload"

    Bypass.expect bypass, fn conn ->
      conn = Plug.Conn.fetch_query_params(conn)
      case conn do
        %{method: "POST", request_path: ^request_path, query_params: %{"uploadId" => ^upload_id}} ->
          send(test_pid, :completed_upload)
          conn
          |> Plug.Conn.send_resp(200, "")

        %{method: "POST", request_path: ^request_path} ->
          body = """
          <InitiateMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
            <Bucket>#{bucket_name}</Bucket>
            <Key>#{path}</Key>
            <UploadId>#{upload_id}</UploadId>
          </InitiateMultipartUploadResult>
          """
          send(test_pid, :initiated_upload)
          conn
          |> Plug.Conn.send_resp(200, body)

        %{method: "PUT", request_path: ^request_path} ->
          send(test_pid, :chunk_uploaded)
          conn
          |> Plug.Conn.put_resp_header("ETag", "abc123")
          |> Plug.Conn.send_resp(200, "")

      end
    end
  end
end
