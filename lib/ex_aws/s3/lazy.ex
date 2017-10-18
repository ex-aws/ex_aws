defmodule ExAws.S3.Lazy do
  @moduledoc false
  ## Implimentation of the lazy functions surfaced by ExAws.S3.Client
  def stream_objects!(bucket, opts, config) do
    request_fun = fn fun_opts ->
      ExAws.S3.list_objects(bucket, Keyword.merge(opts, fun_opts))
      |> ExAws.request!(config)
      |> Map.get(:body)
    end

    Stream.resource(fn -> {request_fun, []} end, fn
      :quit ->
        {:halt, nil}

      {fun, args} ->
        results = fun.(args)
        contents = Map.get(results, :contents, [])
        common_prefixes = Map.get(results, :common_prefixes, [])

        case results do
          %{is_truncated: "true"} ->
            {contents ++ common_prefixes, {fun, [marker: next_marker(results)]}} 
          _ ->
            {contents ++ common_prefixes, :quit}
        end
    end, &(&1))
  end

  def next_marker(%{next_marker: "", contents: contents}) do
    contents
    |> List.last
    |> Map.fetch!(:key)
  end
  def next_marker(%{next_marker: marker}), do: marker
end
