defmodule ExAws.Dynamo.Lazy do
  @moduledoc """
  Dynamo has a few functions that require paging.
  These functions operate just like those in ExAws.Dynamo,
  Except that they return streams instead of lists that can be iterated through
  and will automatically retrieve additional pages as necessary.
  """

  @doc """
  Returns the normally shaped scan result, except that the Items key is now a stream.
  """
  def scan(table, opts \\ %{}) do
    request_fun = fn(fun_opts) ->
      ExAws.Dynamo.scan(table, Map.merge(opts, fun_opts))
    end

    ExAws.Dynamo.scan(table, opts)
      |> do_scan(request_fun)
  end

  defp do_scan({:error, results}, _), do: {:error, results}
  defp do_scan({:ok, results}, request_fun) do
    stream = build_scan_stream({:ok, results}, request_fun)

    {:ok, Map.put(results, "Items", stream)}
  end

  defp build_scan_stream(initial, request_fun) do
    Stream.resource(fn -> initial end, fn
      :quit -> nil

      {:error, items} -> {[{:error, items}], :quit}

      {:ok, %{"Items" => items, "LastEvaluatedKey" => key}} ->
        {items, request_fun.(%{ExclusiveStartKey: key})}

      {:ok, %{"Items" => items}} ->
        {items, :quit}
    end, &pass/1)
  end

  defp pass(x), do: x
end
