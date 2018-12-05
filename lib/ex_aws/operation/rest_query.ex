defmodule ExAws.Operation.RestQuery do
  defstruct http_method: nil,
            path: "/",
            params: %{},
            body: "",
            service: nil,
            action: nil,
            parser: &ExAws.Utils.identity/2

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.Operation.RestQuery do
  def perform(operation, config) do
    headers = []
    url = ExAws.Request.Url.build(operation, config)

    ExAws.Request.request(
      operation.http_method,
      url,
      operation.body,
      headers,
      config,
      operation.service
    )
    |> operation.parser.(operation.action)
  end

  def stream!(%{stream_builder: fun}, config) do
    fun.(config)
  end
end
