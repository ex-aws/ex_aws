defmodule ExAws.Dynamo.Request do
  def request(http_method, data, operation, adapter) do
    ExAws.Request.request(http_method, "/", data, [{"x-amz-target", operation}], adapter)
  end
end
