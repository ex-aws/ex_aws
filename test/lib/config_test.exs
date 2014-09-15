defmodule ExAws.ConfigTest do
  alias ExAws.Config
  use ExUnit.Case, async: true

  test "#namespace_table" do
    name = [TableName: "Foo"] |> Config.namespace_table
    assert name == [TableName: "Foo_test"]
  end
end
