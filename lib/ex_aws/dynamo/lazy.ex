defmodule ExAws.Dynamo.Lazy do
  @moduledoc false
  ## Implimentation of the lazy functions surfaced by ExAws.Dynamo.Client

  def stream_scan(client, table, opts \\ []) do
    request_fun = fn
      {:initial, initial} -> initial
      fun_opts -> ExAws.Dynamo.Impl.scan(client, table, Keyword.merge(opts, fun_opts |> Enum.to_list))
    end

    client
    |> ExAws.Dynamo.Impl.scan(table, opts)
    |> do_request(request_fun)
  end

  defp do_request({:error, results}, _), do: {:error, results}
  defp do_request({:ok, results}, request_fun) do

    stream = build_request_stream({:ok, results}, request_fun)

    {:ok, Map.put(results, "Items", stream)}
  end

  defp build_request_stream(initial, request_fun) do
    Stream.resource(fn -> {request_fun, {:initial, initial}} end, fn
      :quit -> {:halt, nil}

      {fun, args} -> case fun.(args) do

        {:error, items} -> {[{:error, items}], :quit}

        {:ok, %{"Items" => items, "LastEvaluatedKey" => key}} ->
          {items, {fun, %{exclusive_start_key: key}}}

        {:ok, %{"Items" => items}} ->
          {items, :quit}
      end
    end, &pass/1)
  end


  def stream_query(client, table, opts \\ []) do
    request_fun = fn
      {:initial, initial} -> initial
      fun_opts -> ExAws.Dynamo.Impl.query(client, table, Keyword.merge(opts, fun_opts |> Enum.to_list))
    end

    client
    |> ExAws.Dynamo.Impl.query(table, opts)
    |> do_request(request_fun)
  end
  defp pass(val), do: val
end
