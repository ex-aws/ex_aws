defmodule ExAws.SQS.Impl do

  @moduledoc """
  """
  @namespace "Sqs_20121105"
  @actions [
    create_queue:                       :post,
    delete_queue:                       :post,
    get_queue_attributes:               :post,
    set_queue_attributes:               :post,
    list_queues:                        :post,
    get_dead_letter_source_queues:      :post,
    purge_queue:                        :post,
    add_permission:                     :post,
    remove_permission:                  :post,
    send_message:                       :post,
    send_message_batch:                 :post,
    receive_message:                    :post,
    delete_message:                     :post,
    delete_message_batch:               :post,
    change_message_visibility:          :post,
    change_message_visibility_batch:    :post
  ]

end
