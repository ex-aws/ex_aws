defmodule ExAws.S3.Lazy do
  import SweetXml, only: [xpath: 3, sigil_x: 2]
  @moduledoc false
  ## Implimentation of the lazy functions surfaced by ExAws.S3.Client
  def stream_objects(client, bucket, opts \\ []) do
    request_fun = fn fun_opts ->
      ExAws.S3.Impl.list_objects(client, bucket, Keyword.merge(opts, fun_opts))
    end

    Stream.resource(fn -> {request_fun, []} end, fn
      :quit -> {:halt, nil}

      {fun, args} -> case fun.(args) |> parse do

        results = %{contents: contents, is_truncated: "true"} ->
          {contents, {fun, [marker: next_marker(results)]}}

        %{contents: contents} ->
          {contents, :quit}
      end
    end, &(&1))
  end

  def next_marker(%{next_marker: nil, contents: contents}) do
    contents
    |> List.last
    |> Map.get(:key)
  end
  def next_marker(%{next_marker: marker}), do: marker

  def parse({:ok, xml}) do
    xml
    |> xpath(~x"//ListBucketResult",
      name: ~x"./Name/text()",
      is_truncated: ~x"./IsTruncated/text()",
      prefix: ~x"./Prefix/text()",
      marker: ~x"./Marker/text()",
      max_keys: ~x"./MaxKeys/text()",
      next_marker: ~x"./NextMarker/text()",
      contents: [
        ~x"./Contents"l,
        key: ~x"./Key/text()",
        last_modified: ~x"./LastModified/text()",
        e_tag: ~x"./ETag/text()",
        size: ~x"./Size/text()",
        storage_class: ~x"./StorageClass/text()",
        owner: [
          ~x"./Owner",
          id: ~x"./ID/text()",
          display_name: ~x"./DisplayName/text()"
        ]
      ]
    )
    |> binary_values
  end
  def parse(val), do: val

  def binary_values(results) do
    results
    |> Enum.into(%{}, fn
      {:contents, contents} -> {:contents, Enum.map(contents, &binary_values/1)}
      {:owner, v} -> {:owner, binary_values(v)}
      {k, nil} -> {k, nil}
      {k, v} -> {k, IO.chardata_to_string(v)}
    end)
  end
end
