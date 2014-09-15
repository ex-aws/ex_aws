defmodule ExAws.Dynamo.Actions do
  @actions [:batch_get_item, :batch_write_item, :create_table, :delete_item, :delete_table, :describe_table, :get_item, :list_tables, :put_item, :query, :scan, :update_item, :update_table]
    |> Enum.reduce(%{}, fn(action, actions) ->
      name = action |> Atom.to_string |> Mix.Utils.camelize
      Map.put(actions, action, "DynamoDB_20120810.#{name}")
    end)

  def list, do: @actions

  def get(op) do
    @actions |> Map.get(op)
  end
end
