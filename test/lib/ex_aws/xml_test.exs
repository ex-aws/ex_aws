defmodule ExAws.XmlTest do
  use ExUnit.Case, async: true
  alias ExAws.Xml

  test "it adds optional node with text value" do
    parent = {:node, nil, nil} |> Xml.add_optional_node({:new_node, %{foo: :bar}, "value"})
    assert {:node, nil, [{:new_node, %{foo: :bar}, "value"}]} == parent
  end

  test "it add optional node without attrs" do
    parent = {:node, nil, nil} |> Xml.add_optional_node({:new_node, nil, "value"})
    assert {:node, nil, [{:new_node, nil, "value"}]} == parent
  end

  test "it prepends optional node to existing children" do
    parent = {:node, nil, [:child]} |> Xml.add_optional_node({:new_node, nil, "value"})
    assert {:node, nil, [{:new_node, nil, "value"}, :child]} == parent
  end

  test "it add optional node with children that have values" do
    children = [ {:child, nil, "value_child"} ]
    parent = {:node, nil, nil} |> Xml.add_optional_node({:new_node, nil, children})
    assert {:node, nil, [{:new_node, nil, children}]} == parent
  end

  test "it add optional node with children that have attrs" do
    children = [ {:child, %{foo: :bar}, nil} ]
    parent = {:node, nil, nil} |> Xml.add_optional_node({:new_node, nil, children})
    assert {:node, nil, [{:new_node, nil, children}]} == parent
  end

  test "it prepends optional node with children" do
    children = [ {:new_child, nil, "value"} ]
    parent = {:node, nil, [:child]} |> Xml.add_optional_node({:new_node, nil, children})
    assert {:node, nil, [{:new_node, nil, children}, :child]} == parent
  end

  test "it does not add optional node without value or attribute" do
    parent = {:node, nil, nil} |> Xml.add_optional_node({:new_node, nil, nil})
    assert {:node, nil, nil} == parent
  end

  test "it does not add optional node with children that have no attrs or values" do
    children = [ {:child, nil, nil} ]
    parent = {:node, nil, nil} |> Xml.add_optional_node({:new_node, nil, children})
    assert {:node, nil, nil} == parent
  end
end
