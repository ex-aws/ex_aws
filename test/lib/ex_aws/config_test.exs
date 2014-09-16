defmodule ExAws.ConfigTest do
  alias ExAws.Config
  require ExAws.Config
  use ExUnit.Case, async: true

  test "#namespace" do
    name = %{TableName: "Foo"} |> Config.namespace(:dynamo)
    assert name == %{TableName: "Foo_test"}
  end

  test "#config_map" do
    IO.inspect Config.config_map
    assert Config.config_map.ddb_host == Config.aws_config(Config.erlcloud_config, :ddb_host)
  end
end
