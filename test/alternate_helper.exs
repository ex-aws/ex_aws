defmodule Test.KinesisAlt do
  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:http_client, ExAws.Request.Req)
    |> Keyword.put(:json_codec, ExAws.JSON.JSX)
  end
end

defmodule Test.Req do
  def request(method, url, body, headers, _) do
    Req.request(method: method, url: url, body: body, headers: headers)
  end
end

defmodule Test.JSXCodec do
  def encode!(%{} = map) do
    map
    |> Map.to_list()
    |> :jsx.encode()
    |> case do
      "[]" -> "{}"
      val -> val
    end
  end

  def encode(map) do
    {:ok, encode!(map)}
  end

  def decode!(string) do
    :jsx.decode(string)
    |> Map.new()
  end

  def decode(string) do
    {:ok, decode!(string)}
  end
end
