defmodule ExAws.Cloudwatch.IntegrationTest do
  use ExUnit.Case, async: true

  test "check describe_alarams is successful" do
    {:ok, %{body: %{alarms: alarms}}} = ExAws.Cloudwatch.describe_alarms() |> ExAws.request
    assert is_list(alarms)
  end
end
