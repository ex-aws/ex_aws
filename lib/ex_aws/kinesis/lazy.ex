defmodule ExAws.Kinesis.Lazy do
  alias ExAws.Kinesis
  @moduledoc """
  Kinesis has a few functions that require paging.
  These functions operate just like those in Kinesis,
  except that they return streams instead of lists that can be iterated through
  and will automatically retrieve additional pages as necessary.
  """

  @doc """
  Returns the normally shaped AWS response, except the Shards key is now a stream
  """
  def stream_shards(client, stream, opts) do
    request_fun = fn
      {:initial, initial} -> initial
      fun_opts -> Kinesis.Impl.describe_stream(client, stream, Map.merge(opts, fun_opts))
    end

    Kinesis.Impl.describe_stream(client, stream, opts)
    |> do_stream_shards(request_fun)
  end

  defp do_stream_shards({:error, results}, _), do: {:error, results}
  defp do_stream_shards({:ok, results}, request_fun) do
    stream = build_shard_stream({:ok, results}, request_fun)

    {:ok, put_in(results["StreamDescription"], %{"Shards" => stream})}
  end

  defp build_shard_stream(initial, request_fun) do
    Stream.resource(fn -> {request_fun, {:initial, initial}} end, fn
      :quit -> {:halt, nil}
      {fun, args} -> case fun.(args) do

        {:error, results} -> {[{:error, results}], :quit}

        {:ok, %{"StreamDescription" => %{"Shards" => shards, "HasMoreShards" => true}}} ->
          opts = %{ExclusiveStartShardId: shards |> List.last |> Map.get("ShardId")}
          {shards, {fun, opts}}

        {:ok, %{"StreamDescription" => %{"Shards" => shards}}} ->
          {shards, :quit}
      end
    end, &pass/1)
  end

  defp pass(x), do: x

  @doc """
  Returns a stream of record shard iterator tuples.
  NOTE: This stream is basically INFINITE, in that it runs
  until the shard it is reading from closes, which may be never.
  """
  def stream_records(client, shard_iterator, opts, fun \\ &pass/1) do
    sleep_time = Application.get_env(:ex_aws, :kinesis_sleep_between_req_time) || 200

    request_fun = fn(fun_opts) ->
      :timer.sleep(sleep_time)
      req_opts = Map.merge(opts, fun_opts)
      Kinesis.Impl.get_records(client, shard_iterator, req_opts)
    end

    build_record_stream(request_fun, fun)
  end

  defp build_record_stream(request_fun, iteration_fun) do
    Stream.resource(fn -> {request_fun, %{}} end, fn
      :quit -> {:halt, nil}

      {fun, args} -> case fun.(args) do

        {:error, results} -> {iteration_fun.([{:error, results}]), :quit}

        {:ok, %{"Records" => records, "NextShardIterator" => shard_iter}} ->
          {
            records |> iteration_fun.(),
            {fun, %{ShardIterator: shard_iter}}
          }

        {:ok, %{"Records" => records}} ->
          {iteration_fun.(records), :quit}
      end
    end, &pass/1)
  end
end
