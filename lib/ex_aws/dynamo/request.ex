defmodule ExAws.Dynamo.Request do
  def request(data, action, adapter) do
    {operation, http_method} = ExAws.Dynamo |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.0"}
    ]
    ExAws.Request.request(http_method, "/", data, headers, adapter)
  end
end
