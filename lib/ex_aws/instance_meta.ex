defmodule ExAws.InstanceMeta do
  @meta_path_root "http://169.254.169.254/latest/meta-data/"

  def request(%{config: config}, path) do
    case config.http_client.request(:get, @meta_path_root <> path) do
      {:ok, %{body: body}} -> body
    end
    |> config.json_codec.decode!
  end
end
