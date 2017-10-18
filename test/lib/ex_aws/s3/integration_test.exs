defmodule ExAws.S3IntegrationTest do
  use ExUnit.Case, async: true

  test "#list_buckets" do
    assert {:ok, %{body: body}} = ExAws.S3.list_buckets |> ExAws.request
    assert %{buckets: _} = body
  end

  test "#list_objects with stream! with delimiter (with no results)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "zzzyyyxxxwww") |> ExAws.stream! |> Enum.to_list

    assert [] = results
  end

  test "#list_objects with stream! with delimiter (folders, will not paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "folders/short/") |> ExAws.stream! |> Enum.to_list

    assert [
      %{prefix: "folders/short/0001/"},
      %{prefix: "folders/short/0002/"},
      %{prefix: "folders/short/0003/"}
    ] = results
  end

  test "#list_objects with stream! with delimiter (folders, will paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "folders/long/") |> ExAws.stream! |> Enum.to_list

    assert [%{prefix: "folders/long/0001/"} | _t] = results
    assert length(results) == 1200
  end

  test "#list_objects with stream! with delimiter (objects, will not paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "objects/short/") |> ExAws.stream! |> Enum.to_list

    assert [
      %{e_tag: _, key: "objects/short/0001"},
      %{e_tag: _, key: "objects/short/0002"},
      %{e_tag: _, key: "objects/short/0003"},
    ] = results
  end

  test "#list_objects with stream! with delimiter (objects, will paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "objects/long/") |> ExAws.stream! |> Enum.to_list

    assert [%{e_tag: _, key: "objects/long/0001"} | _t] = results
    assert length(results) == 1200
  end

  test "#list_objects with stream! with delimiter (neither paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "mixed/neither_paginate/") |> ExAws.stream! |> Enum.to_list

    assert [
      %{e_tag: _, key: "mixed/neither_paginate/0001"},
      %{e_tag: _, key: "mixed/neither_paginate/0002"},
      %{e_tag: _, key: "mixed/neither_paginate/0003"},
      %{prefix: "mixed/neither_paginate/d0001/"},
      %{prefix: "mixed/neither_paginate/d0002/"},
      %{prefix: "mixed/neither_paginate/d0003/"},
    ] = results
  end

  test "#list_objects with stream! with delimiter (both paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "mixed/both_paginate/") |> ExAws.stream! |> Enum.to_list

    assert length(results) == 2400
    assert 1200 = length(for %{e_tag: e} <- results, do: e)
    assert 1200 = length(for %{prefix: e} <- results, do: e)
  end

  test "#list_objects with stream! with delimiter (objects paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "mixed/objects_paginate/") |> ExAws.stream! |> Enum.to_list

    assert length(results) == 1203
    assert 1200 = length(for %{e_tag: e} <- results, do: e)
    assert 3 = length(for %{prefix: e} <- results, do: e)
  end

  test "#list_objects with stream! with delimiter (folders paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "mixed/folders_paginate/") |> ExAws.stream! |> Enum.to_list

    assert length(results) == 1203
    assert 3 = length(for %{e_tag: e} <- results, do: e)
    assert 1200 = length(for %{prefix: e} <- results, do: e)
  end
end
