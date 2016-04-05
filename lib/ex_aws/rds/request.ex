defmodule ExAws.RDS.Request do
  
  @moduledoc false
  # RDS specific request logic

  def request(client, http_method, instance, path, data \\ []) do
    new_data = data 
               |> Keyword.get(:params, %{}) 
               |> convert_data_keys_to_capitalized_strings

    body     = data |> Keyword.get(:body, "")
    resource = data |> Keyword.get(:resource, "")
    query    = new_data |> URI.encode_query
    headers  = data |> Keyword.get(:headers, %{})

    new_config = Map.merge(client.config, 
                           %{
                            host: "rds.amazonaws.com", 
                            scheme: "https://",
                            region: "us-east-1"
                            })

    client = Map.put(client, :config, new_config)

    url = client.config
    |> url(path)
    |> add_query(resource, query)

    hashed_payload = ExAws.Auth.Utils.hash_sha256(body)

    headers = headers
    |> Map.put("x-amz-content-sha256", hashed_payload)
    |> Map.put("content-length", byte_size(body))
    |> Map.to_list

    ExAws.Request.request(http_method, url, body, headers, client)
  end

  def url(%{scheme: scheme, host: host} = config, path) do 
    (scheme <> host <> path)
    |> IO.iodata_to_binary
  end

  def add_query(url, "", "") do 
    url
  end

  def add_query(url, "", query) do
    url <> "?" <> query
  end

  def add_query(url, resource, "") do
    resource = resource |> Atom.to_string |> String.capitalize
    url <> "?" <> resource
  end

  def add_query(url, resource, query) do 
    resource = resource |> Atom.to_string |> String.capitalize
    url <> "?" <> resource <> "&" <> query
  end

  def ensure_slash("/" <> _ = path), do: path
  def ensure_slash(path), do:  "/" <> path

  defp convert_data_keys_to_capitalized_strings(data) do 
    new_data = Map.new
    for {key, val} <- data do
      key = key |> Atom.to_string |> String.capitalize 
      new_data = Map.put_new(new_data, key, val)
    end
  end
end