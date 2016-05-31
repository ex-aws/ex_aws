defmodule ExAws.Dynamo.Lazy do
  @moduledoc false
  ## Implimentation of the lazy functions surfaced by ExAws.Dynamo.Client

  @doc "Generates a scan stream"
  def stream_scan(table, opts, config) do
    request_fun = fn fun_opts ->
      ExAws.Dynamo.scan(table, Keyword.merge(opts, fun_opts))
      |> ExAws.request!(config)
    end

    build_request_stream(request_fun)
  end

  defp build_request_stream(request_fun) do
    Stream.resource(fn -> {request_fun, []} end, fn
      :quit -> {:halt, nil}

      {fun, args} -> case fun.(args) do

        %{"Items" => items, "LastEvaluatedKey" => key} ->
          {items, {fun, [exclusive_start_key: key]}}

        %{"Items" => items} ->
          {items, :quit}
      end
    end, &pass/1)
  end

  @doc "Generates a query stream"
  def stream_query(table, opts, config) do
    request_fun = fn fun_opts ->
      ExAws.Dynamo.query(table, Keyword.merge(opts, fun_opts))
      |> ExAws.request!(config)
    end

    build_request_stream(request_fun)
  end

  defp pass(val), do: val
end
