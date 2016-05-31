defmodule ExAws.Operation do
  defstruct [
    request_module: nil,
    post_processor: nil,
    stream_builder: nil,
    http_method: nil,
    path: "/",
    data: "",
    headers: [],
    service: nil
  ]

  @type t :: %__MODULE__{}
end
