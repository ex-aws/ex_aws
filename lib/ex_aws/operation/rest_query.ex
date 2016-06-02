defmodule ExAws.Operation.RestQuery do
  defstruct [
    http_method: nil,
    path: "/",
    params: %{},
    service: nil,
  ]
end
