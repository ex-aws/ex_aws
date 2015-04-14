defmodule ExAws.Kinesis.Request do
  def request(data, action, adapter) do
    {operation, http_method} = ExAws.Kinesis |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.1"}
    ]
    ExAws.Request.request(http_method, "/", data, headers, adapter)
  end
end
