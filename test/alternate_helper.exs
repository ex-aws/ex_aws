defmodule Test.KinesisAlt do
  use ExAws.Kinesis.Adapter

  def config do
    Keyword.merge(super, Application.get_env(:ex_aws, :kinesis))
    |> Keyword.put(:http_client, Test.HTTPotion)
    |> Keyword.put(:json_codec, Test.JSXCodec)
  end
end

Application.ensure_all_started(:httpotion)
defmodule Test.HTTPotion do
  def post(url, body, headers) do
    {:ok, HTTPotion.post(url, [body: body, headers: headers, ibrowse: [headers_as_is: true]])}
  end
end

defmodule Test.JSXCodec do
  def encode!(%{} = map) do
    map
    |> Map.to_list
    |> :jsx.encode
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
    |> Enum.into(%{})
  end

  def decode(string) do
    {:ok, decode!(string)}
  end
end
