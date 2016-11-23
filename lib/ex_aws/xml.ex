defmodule ExAws.Xml do
  @moduledoc false

  def add_optional_node(nodes, {_, nil, nil}), do: nodes

  def add_optional_node({name, attrs, nodes} = parent, {_, nil, children} = node) when is_list(children) do
    children_with_content = children |> Enum.reject(&without_attrs_or_content/1)
    case children_with_content do
      [] -> parent
      _ -> {name, attrs, [node | List.wrap(nodes)]}
    end
  end

  def add_optional_node({name, attrs, nil}, node), do: {name, attrs, [node]}
  def add_optional_node({name, attrs, nodes}, node), do: {name, attrs, [node | nodes]}

  defp without_attrs_or_content({_, nil, nil}), do: true
  defp without_attrs_or_content({_, _, _}), do: false
end
