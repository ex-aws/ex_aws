defmodule ExAws.Request.Context do
  defstruct service: nil,
    error_parser: &Function.identity/1

  def new(service, opts \\ [])
  def new(service, opts) do
    struct(%__MODULE__{service: service}, opts)
  end
end
