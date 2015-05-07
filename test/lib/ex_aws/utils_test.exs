defmodule ExAws.UtilsTest do
  use ExUnit.Case, async: true
  import ExAws.Utils

  test "camelize_keys works with maps" do
    assert %{"HelloWorld" => "foo"} == %{hello_world: "foo"}
    |> camelize_keys
  end

  test "camelize_keys does not go deep unless specified maps" do
    assert %{"FooBar" => %{foo_bar: "baz"}} == %{foo_bar: %{foo_bar: "baz"}}
    |> camelize_keys

    assert %{"FooBar" => %{"FooBar" => "baz"}} == %{foo_bar: %{foo_bar: "baz"}}
    |> camelize_keys(deep: true)
  end

  test "camelize_keys can handle keyword lists" do
    assert %{"FooBar" => %{"FooBar" => "baz"}} == [foo_bar: [foo_bar: "baz"]]
    |> camelize_keys(deep: true)
  end

  test "camelize_keys can handle handle lists that aren't keyword lists" do
    assert %{"FooBar" => ["foo", "bar"]} == [foo_bar: ["foo", "bar"]]
    |> camelize_keys(deep: true)
  end
end
