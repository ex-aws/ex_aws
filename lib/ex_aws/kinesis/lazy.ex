defmodule ExAws.Kinesis.Lazy do
  alias ExAws.Kinesis
  @moduledoc false
  # Implimentation of lazy functions surfaced by ExAws.Kinesis.Client

  def stream_shards(client, stream, opts \\ []) do
    request_fun = fn
      {:initial, initial} -> initial
      fun_opts -> Kinesis.Impl.describe_stream(client, stream, Map.merge(opts, fun_opts))
    end

    client
    |> Kinesis.Impl.describe_stream(stream, opts)
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

        {:ok, %{"StreamDescription" => %{"Shards" => shards, "HasMoreShards" => true}}} ->
          opts = %{"ExclusiveStartShardId" => shards |> List.last |> Map.get("ShardId")}
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
  def stream_records(client, shard_iterator, opts \\ [], each_req_fun \\ &pass/1) do
    sleep_time = Keyword.get(opts, :sleep_between_req_time, 200)

    request_fun = fn shard_iter ->
      :timer.sleep(sleep_time)
      Kinesis.Impl.get_records(client, shard_iter, opts)
    end

    build_record_stream(request_fun, shard_iterator, each_req_fun)
  end

  defp build_record_stream(request_fun, shard_iterator, each_req_fun) do
    Stream.resource(fn -> {request_fun, shard_iterator} end, fn
      :quit -> {:halt, nil}

      {fun, shard_iter} -> case fun.(shard_iter) do

        {:ok, %{"Records" => records, "NextShardIterator" => shard_iter}} ->
          {
            records |> each_req_fun.(),
            {fun, shard_iter}
          }

        {:ok, %{"Records" => records}} ->
          {each_req_fun.(records), :quit}
      end
    end, &pass/1)
  end
end
