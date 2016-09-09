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

  test "iso_z_to_secs/1" do
    assert iso_z_to_secs("2015-07-05T22:16:18Z") == 1436134578
  end

  test "add_seconds/2" do
    assert add_seconds({{2016, 8, 29}, {22, 31, 19}}, 10) == {{2016, 8, 29}, {22, 31, 29}}
  end
end
