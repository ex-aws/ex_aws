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

  test "iso_z_to_secs converts iso string to epoch seconds" do
    assert 1436134578 == iso_z_to_secs("2015-07-05T22:16:18Z")
  end

  test "rename_keys renames keys in a list of keywords" do
    assert [d: 1, b: 2, e: 3] == [a: 1, b: 2, c: 3] |> rename_keys(a: :d, c: :e)
  end

  test "build_indexed_params creates key value pairs from key_template and list" do
    assert [{"key.1", 1}, {"key.2", 2}] == build_indexed_params("key.{i}", [1,2])
  end

  test "build_indexed_params creates key value pair from key_template and single element" do
    assert [{"key.1", 1}] == build_indexed_params("key.{i}", 1)
  end

  test "build_indexed_params creates key value pairs from list of key_templates" do
    expected_return = [
        {"foo.1", 1}, {"foo.2", 2}, 
        {"bar.1", 3}, {"bar.2", 4},
      ]
    index_params = build_indexed_params([ 
        {"foo.{i}", [1,2]}, 
        {"bar.{i}", [3,4]},
      ])

    assert expected_return == index_params
  end
end
