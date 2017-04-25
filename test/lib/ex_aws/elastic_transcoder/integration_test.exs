defmodule ExAws.ElasticTranscoder.IntegrationTest do
  use ExUnit.Case, async: true
  alias ExAws.ElasticTranscoder

  test "list_pipelines" do
    assert {:ok, %{"Pipelines" => _}} = ElasticTranscoder.list_pipelines() |> ExAws.request
  end
end
