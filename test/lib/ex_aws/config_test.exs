defmodule ExAws.ConfigTest do
  alias ExAws.Config
  use ExUnit.Case, async: true

  test "#namespace" do
    name = %{TableName: "Foo"} |> Config.namespace(:dynamo)
    assert name == %{TableName: "Foo-test"}
  end

  test "#namespace atom" do
    assert Config.namespace(:foo, :dynamo) == "foo-test"
  end

  test "#namespace Elixir atom" do
    assert Config.namespace(Foo, :dynamo) == "Elixir.Foo-test"
  end
end
