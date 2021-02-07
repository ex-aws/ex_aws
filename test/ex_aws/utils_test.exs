defmodule ExAws.UtilsTest do
  use ExUnit.Case, async: true
  import ExAws.Utils

  test "camelize_keys works with maps" do
    assert %{"HelloWorld" => "foo"} ==
             %{hello_world: "foo"}
             |> camelize_keys
  end

  test "camelize_keys does not go deep unless specified maps" do
    assert %{"FooBar" => %{foo_bar: "baz"}} ==
             %{foo_bar: %{foo_bar: "baz"}}
             |> camelize_keys

    assert %{"FooBar" => %{"FooBar" => "baz"}} ==
             %{foo_bar: %{foo_bar: "baz"}}
             |> camelize_keys(deep: true)
  end

  test "camelize_keys can handle keyword lists" do
    assert %{"FooBar" => %{"FooBar" => "baz"}} ==
             [foo_bar: [foo_bar: "baz"]]
             |> camelize_keys(deep: true)
  end

  test "camelize_keys can handle handle lists that aren't keyword lists" do
    assert %{"FooBar" => ["foo", "bar"]} ==
             [foo_bar: ["foo", "bar"]]
             |> camelize_keys(deep: true)
  end

  test "camelize_keys spec works for non-standard keys" do
    assert %{"non-standard" => ["foo", "bar"]} ==
             [foo_bar: ["foo", "bar"]]
             |> camelize_keys(spec: %{foo_bar: "non-standard"})
  end

  test "rename_keys renames keys in a list of keywords" do
    assert [d: 1, b: 2, e: 3] == [a: 1, b: 2, c: 3] |> rename_keys(a: :d, c: :e)
  end

  test "format (:xml) creates single key value pair" do
    assert [{"Key", 1}] == format([key: 1], type: :xml)
  end

  test "format (:xml) creates key value pairs from key_template and list" do
    assert [{"Key.1", 1}, {"Key.2", 2}] == format([key: [1, 2]], type: :xml)
  end

  test "format (:xml) spec works for non-standard keys" do
    assert [{"non-standard.1", 1}, {"non-standard.2", 2}] ==
             format([foo_bar: [1, 2]], spec: %{foo_bar: "non-standard"}, type: :xml)
  end

  test "format (:xml) creates key value pairs from list of key_templates" do
    expected_return = [
      {"Tag.1.Key", "keyA"},
      {"Tag.1.Value", "ValueA"},
      {"Tag.2.Key", "keyB"},
      {"Tag.2.Value", "keyB"},
      {"Member", "member!"}
    ]

    assert expected_return ==
             format(
               [
                 tag: [
                   [key: "keyA", value: "ValueA"],
                   [key: "keyB", value: "keyB"]
                 ],
                 member: "member!"
               ],
               type: :xml
             )
  end
end
