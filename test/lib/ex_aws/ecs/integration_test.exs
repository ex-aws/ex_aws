defmodule ExAws.ECSIntegrationTest do
  use ExUnit.Case, async: true

  # NOTE
  # These tests run against the actual ECS service.
  # No functions should be called that in any way alter state.
  #

  test "#list_clusters" do
    assert {:ok, %{"clusterArns" => _ }} = ExAws.ECS.list_clusters |> ExAws.request
  end

  test "#list_task_definitions" do
    assert {:ok, %{"taskDefinitionArns" => _ }} = ExAws.ECS.list_task_definitions(status: :INACTIVE) |> ExAws.request
  end

end
