defmodule ExAws.SQS.Client do
  use Behaviour

  @moduledoc """
  The purpose of this module is to surface the ExAws.SQS API tied to a single
  configuration chose, such that it does not need passed in with every request

  Usage:
  ```elixir
  defmodule MyApp.SQS do
    use ExAws.SQS.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```elixir
  config :my_otp_app, ExAws,
    sqs: [], #SQS config goes here
  ```
  """

  @type sqs_permission :: 
    :all | 
    :receive_message | 
    :delete_message |
    :change_message_visibility | 
    :get_queue_attributes 
  @type sqs_acl :: [{binary, sqs_permission}]
  @type sqs_message_attribute_name ::
    :all |
    :sender_id | 
    :sent_timestamp |
    :approximate_receive_count |
    :approximate_first_receive_timestamp |
    :wait_time_seconds |
    :receive_message_wait_time_seconds 
  @type sqs_queue_attribute_name ::
    :all | 
    :approximate_number_of_messages |
    :approximate_number_of_messages_not_visible | 
    :visibility_timeout |
    :created_timestamp | 
    :last_modified_timestamp | 
    :policy  
  @type sqs_message :: [
    {:message_body, binary},
    {:delay_seconds, 0..900 | none},
    {:attributes, Keyword.t }
  ]

 @doc "Create queue"
  defcallback create_queue(queue_name :: binary, visibility_timeout :: 0..43200 | none) :: ExAws.Request.response_t

  @doc "Delete a queue"
  defcallback delete_queue(queue_name :: binary) :: ExAws.Request.response_t

  @doc "Gets attributes of a SQS Queue"
  defcallback get_queue_attributes(queue_name :: binary, attribute_names :: [sqs_queue_attribute_name] | :all) :: ExAws.Request.response_t

  @doc "Set attributes of a SQS Queue"
  @type queue_attributes :: [
    {:visibility_timeout, Integer} |
    {:policy, binary}
  ]
  defcallback set_queue_attributes(queue_name :: binary, attributes :: queue_attributes) :: ExAws.Request.response_t
  
  @doc "Retrieces a list of all the SQS Queues"
  defcallback list_queues() :: ExAws.Request.response_t

  @doc "Retrieves the dead letter source queues for a given SQS Queue"
  defcallback get_dead_letter_source_queues(queue_name :: binary) :: ExAws.Request.response_t 
  @doc "Purge all messages in a SQS Queue"
  defcallback purge_queue(queue_name :: binary) :: ExAws.Request.response_t

  @doc "Add permission"
  defcallback add_permission(queue_name :: binary, label :: binary, permissions :: sqs_acl) :: ExAws.Request.response_t
  
  @doc "Remove permission"
  defcallback remove_permission(queue_name :: binary, label :: binary) :: ExAws.Request.response_t
  
   @doc "Send a message to a SQS Queue"
  defcallback send_message(queue_name :: binary, message :: sqs_message) :: ExAws.Request.response_t 
  defcallback send_message(queue_name :: binary, message_body :: binary, delay_seconds :: 0..900 | none) :: ExAws.Request.response_t
  
  @doc "Send up to 10 messages to a SQS Queue in a single request"
  defcallback send_messages(queue_name :: binary, messages :: [sqs_message, ...]) :: ExAws.Request.response_t 

  @doc "Read messages from a SQS Queue"
  defcallback receive_message(queue_name :: binary, attribute_names :: [sqs_message_attribute_name] | :all, max_number_of_messages :: 1..10, visibility_timeout :: 0..43200 | none, wait_timeout :: 0..20 | none) :: ExAws.Request.response_t
  
  @doc "Delete a message from a SQS Queue"
  defcallback delete_message(queue_name :: binary, receipt_handle :: binary) :: ExAws.Request.response_t

  @doc "Deletes a list of messages from a SQS Queue in a single request"
  defcallback delete_messages(queue_name :: binary, receipt_handles :: [binary, ...]) :: ExAws.Request.response_t
 
  @doc """
  Extends the read lock timeout for the specified message from
  the specified queue to the specified value
  """
  defcallback change_message_visibility(queue_name :: binary, receipt_handle :: binary, visibility_timeout :: 0..43200) :: ExAws.Request.response_t 

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      unquote(boilerplate)

      @doc false
      def request(queue_name, action, params \\ []) do
        ExAws.SQS.Request.request(__MODULE__, queue_name, action, params)
      end

      @doc false
      def service, do: :sqs

      defoverridable config_root: 0, request: 2, request: 3
  
    end     
  end
end
