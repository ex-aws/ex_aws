defmodule ExAws.Lambda do
  use ExAws.Lambda.Adapter
  use ExAws.Actions

  @namespace "Lambda"
  @actions [
    add_permission:                :post,
    create_event_source_mapping:   :post,
    create_function:               :post,
    delete_event_source_mapping:   :delete,
    delete_function:               :delete,
    get_event_source_mapping:      :get,
    get_function:                  :get,
    get_function_configuration:    :get,
    get_policy:                    :get,
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
