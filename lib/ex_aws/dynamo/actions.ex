defmodule ExAws.Dynamo.Actions do
  use ExAws.Actions

  @namespace "DynamoDB_20120810"
  @actions [:batch_get_item, :batch_write_item, :create_table, :delete_item,
    :delete_table, :describe_table, :get_item, :list_tables, :put_item,
    :query, :scan, :update_item, :update_table]
end
