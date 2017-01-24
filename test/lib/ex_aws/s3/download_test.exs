defmodule ExAws.S3.DownloadTest do
  use ExUnit.Case

  import Support.FileHelpers
  import Support.BypassHelpers
  alias ExAws.S3

  describe "integration test" do
    setup [:start_bypass]

    test "downloading a file", %{bypass: bypass} do
      file_body = "hello world"

      setup_multipart_download_backend(bypass, self(), "my-bucket", "test.txt", file_body)

      in_tmp fn _ ->
        :done =
          "my-bucket"
          |> S3.download_file("test.txt", "downloaded_file.txt")
          |> ExAws.request!(exaws_config_for_bypass(bypass))

        assert_received :fetched_file_size
        assert_received :downloaded_chunk

        assert_file "downloaded_file.txt", file_body
      end
    end
  end

  defp setup_multipart_download_backend(bypass, test_pid, bucket_name, path, file_body) do
    request_path = "/#{bucket_name}/#{path}"

    Bypass.expect bypass, fn conn ->
      case conn do
        %{method: "HEAD", request_path: ^request_path} ->
          send(test_pid, :fetched_file_size)
          conn
          |> Plug.Conn.put_resp_header("Content-Length", file_body |> byte_size |> to_string)
          |> Plug.Conn.send_resp(200, "")
        %{method: "GET", request_path: ^request_path} ->
          send(test_pid, :downloaded_chunk)
          conn
          |> Plug.Conn.send_resp(200, file_body)
      end
    end
  end
end
