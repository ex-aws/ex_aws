defmodule ExAws.Operation.Polly do
  @moduledoc """
  Holds data necessary for an operation on the Polly service.
  """

  defstruct [stream_builder: nil,
             parser: &ExAws.Utils.identity/1,
             path: "/",
             http_method: nil,
             body: "",
             version: "",
             resource: "",
             lexicon_name: "",
             params: %{},
             headers: %{},
             service: :polly]

  @type t :: %__MODULE__{}

  defimpl ExAws.Operation do
    def perform(operation, config) do
      headers = operation.headers
      url =
        operation
        |> build_path()
        |> ExAws.Request.Url.build(config)
      headers =
        headers
        |> Map.put("x-amz-content-sha256", "")
        |> Map.to_list
      ExAws.Request.request(operation.http_method, url, operation.params, headers, config, operation.service)
      |> operation.parser.(config)
    end

    def stream!(%ExAws.Operation.Polly{stream_builder: nil}, _) do
      raise(ArgumentError, "This operation does not support streaming!")
    end

    def stream!(%ExAws.Operation.Polly{stream_builder: fun}, config) do
      fun.(config)
    end

    def build_path(operation) do
      version = operation.version
      resource = operation.resource
      lexicon_name = operation.lexicon_name
      path = "/#{version}/#{resource}"
      path =
        cond do
          resource == "lexicons" and lexicon_name != "" -> "#{path}/#{lexicon_name}"
          true -> path
        end
        |> String.trim_leading("//")
      Map.put(operation, :path, path)
    end
  end
end
