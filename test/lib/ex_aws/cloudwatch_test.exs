defmodule ExAws.CloudwatchTest do
  use ExUnit.Case, async: true
  alias ExAws.Cloudwatch

  doctest ExAws.Cloudwatch
  
  test "#describe_alarms" do
    expected = %{"Action" => "DescribeAlarms", "Version" => "2010-08-01"}
    assert expected == Cloudwatch.describe_alarms().params
  end
end
