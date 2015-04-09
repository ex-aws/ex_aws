defmodule ExAws.Lambda do
  use ExAws.Actions

  @namespace "Lambda"
  @actions [
    add_permission:                :post,
    create_event_source_mapping:   :post,
    create_function:               :post,
    delete_event_source_mapping:   :post,
    delete_function:               :post,
    get_event_source_mapping:      :post,
    get_function:                  :post,
    get_function_configuration:    :post,
    get_policy:                    :post,
    invoke:                        :post,
    invoke_async:                  :post,
    list_event_source_mappings:    :post,
    list_functions:                :post,
    remove_permission:             :post,
    update_event_source_mapping:   :post,
    update_function_code:          :post,
    update_function_configuration: :post
  ]
end
