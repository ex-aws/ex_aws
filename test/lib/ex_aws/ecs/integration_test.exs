defmodule ExAws.ECSIntegrationTest do
  use ExUnit.Case, async: true

  # NOTE
  # These tests run against the actual ECS service.
  # No functions should be called that in any way alter state.
  #

  test "#list_clusters" do
    assert {:ok, %{"clusterArns" => _ }} = ExAws.ECS.list_clusters |> ExAws.request
  end

end
