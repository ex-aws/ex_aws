defmodule ExAws.SNS.Request do
  @moduledoc false
  # SNS specific request logic.

  @empty_body_hash AWSAuth.Utils.hash_sha256("")

  def request(client, action, params) do
    query = params
    |> Map.put("Action", Mix.Utils.camelize(Atom.to_string(action)))
    |> URI.encode_query

    headers = [
      {"x-amz-content-sha256", @empty_body_hash}
    ]

    ExAws.Request.request(:post, client.config |> url(query), "", headers, client)
  end

  defp url(%{scheme: scheme, host: host}, query) do
    [scheme, host, "/?", query]
    |> IO.iodata_to_binary
  end
end
