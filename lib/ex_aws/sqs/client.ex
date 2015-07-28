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
    :send_message |
    :receive_message |
    :delete_message |
    :change_message_visibility |
    :get_queue_attributes
  @type sqs_acl :: %{ binary => sqs_permission | [sqs_permission, ...]}
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
  @type visibility_timeout :: 0..43200
  @type queue_attributes :: [
    {:visibility_timeout, visibility_timeout} |
    {:policy, binary}
  ]
  @type sqs_message_attribute :: %{
    :name => binary,
    :data_type => :string | :number | :binary,
    :custom_type => binary | none,
    :value => binary | number
  }

  @doc "Create queue"
  defcallback create_queue(queue_name :: binary) :: ExAws.Request.response_t
  defcallback create_queue(queue_name :: binary, visibility_timeout :: visibility_timeout) :: ExAws.Request.response_t

  @doc "Delete a queue"
  defcallback delete_queue(queue_name :: binary) :: ExAws.Request.response_t

  @doc "Gets attributes of a SQS Queue"
  defcallback get_queue_attributes(queue_name :: binary) :: ExAws.Request.response_t
  defcallback get_queue_attributes(queue_name :: binary, attribute_names :: sqs_queue_attribute_name | [sqs_queue_attribute_name, ...]) :: ExAws.Request.response_t

  @doc "Set attributes of a SQS Queue"
  defcallback set_queue_attributes(queue_name :: binary, attributes :: queue_attributes) :: ExAws.Request.response_t

  @doc "Retrieves a list of all the SQS Queues"
  defcallback list_queues() :: ExAws.Request.response_t

  @doc "Retrieves the dead letter source queues for a given SQS Queue"
  defcallback get_dead_letter_source_queues(queue_name :: binary) :: ExAws.Request.response_t

  @doc "Purge all messages in a SQS Queue"
  defcallback purge_queue(queue_name :: binary) :: ExAws.Request.response_t

  @doc """
  Adds a permission with the provided label to the Queue
  for a specific action for a specific account.
  """
  defcallback add_permission(queue_name :: binary, label :: binary, permissions :: sqs_acl) :: ExAws.Request.response_t

  @doc "Removes permission with the given label from the Queue"
  defcallback remove_permission(queue_name :: binary, label :: binary) :: ExAws.Request.response_t

  @doc "Send a message to a SQS Queue"
  @type sqs_message_opts :: [
      {:delay_seconds, 0..900} |
      {:attributes, sqs_message_attribute | [sqs_message_attribute, ...]}
  ]
  defcallback send_message(queue_name :: binary, message_body :: binary) :: ExAws.Request.response_t
  defcallback send_message(queue_name :: binary, message_body :: binary, opts :: sqs_message_opts) :: ExAws.Request.response_t

  @doc "Send up to 10 messages to a SQS Queue in a single request"
  @type sqs_batch_message :: binary |
  [
    {:message_body, binary} |
    {:delay_seconds, 0..900} |
    {:attributes, sqs_message_attribute | [sqs_message_attribute, ...]}
  ]
  defcallback send_message_batch(queue_name :: binary, messages :: [sqs_batch_message, ...]) :: ExAws.Request.response_t

  @doc "Read messages from a SQS Queue"
  @type receive_message_opts :: [
    {:attribute_names, sqs_message_attribute_name | [sqs_message_attribute_name, ...]} |
    {:max_number_of_messages, 1..10} |
    {:visibility_timeout, 0..43200} |
    {:wait_timeout, 0..20}
  ]
  defcallback receive_message(queue_name :: binary) :: ExAws.Request.response_t
  defcallback receive_message(queue_name :: binary, opts :: receive_message_opts) :: ExAws.Request.response_t

  @doc "Delete a message from a SQS Queue"
  defcallback delete_message(queue_name :: binary, receipt_handle :: binary) :: ExAws.Request.response_t

  @doc "Deletes a list of messages from a SQS Queue in a single request"
  defcallback delete_message_batch(queue_name :: binary, receipt_handles :: [binary, ...]) :: ExAws.Request.response_t

  @doc """
  Extends the read lock timeout for the specified message from
  the specified queue to the specified value
  """
  defcallback change_message_visibility(queue_name :: binary, receipt_handle :: binary, visibility_timeout :: visibility_timeout) :: ExAws.Request.response_t

  @doc """
  Extends the read lock timeout for a batch of 1..10 messages
  """
  @type message_visibility_batch :: %{
    :id => binary,
    :receipt_handle => binary,
    :visibility_timeout => visibility_timeout
  }
  defcallback change_message_visibility_batch(queue_name :: binary, opts :: [message_visibility_batch, ...]) :: ExAws.Request.response_t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :sqs
      unquote(boilerplate)

      @doc false
      def request(client, queue_name, action, params \\ []) do
        ExAws.SQS.Request.request(client, queue_name, action, params)
      end

      defoverridable config_root: 0, request: 3, request: 4

    end
  end
end
