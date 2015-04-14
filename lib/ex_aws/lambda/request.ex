defmodule ExAws.Lambda.Request do
  def request(data, action, path, adapter, params \\ [], headers \\ []) do
    {_, http_method} = ExAws.Lambda |> ExAws.Actions.get(action)
    path = [path, params |> URI.encode_query] |> IO.iodata_to_binary

    headers = [{"content-type", "application/json"} | headers]
    ExAws.Request.request(http_method, path, data, headers , adapter)
  end
end
