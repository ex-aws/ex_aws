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
    :send_message |
    :receive_message |
    :delete_message |
    :change_message_visibility |
    :get_queue_attributes
  @type sqs_acl :: %{ binary => :all | [sqs_permission, ...]}
  @type sqs_message_attribute_name ::
    :sender_id |
    :sent_timestamp |
    :approximate_receive_count |
    :approximate_first_receive_timestamp |
    :wait_time_seconds |
    :receive_message_wait_time_seconds
  @type sqs_queue_attribute_name ::
    :policy
    | :visibility_timeout
    | :maximum_message_size
    | :message_retention_period
    | :approximate_number_of_messages
    | :approximate_number_of_messags_not_visible
    | :created_timestamp
    | :last_modified_timestamp
    | :queue_arn
    | :approximate_number_of_messages_delayed
    | :delay_seconds
    | :receive_message_wait_time_seconds
    | :redrive_policy
  @type visibility_timeout :: 0..43200
  @type queue_attributes :: [
    | {:policy, binary}
    | {:visibility_timeout, visibility_timeout}
    | {:maximum_message_size, 1024..262144}
    | {:message_retention_period, 60..1209600}
    | {:approximate_number_of_messages, binary}
    | {:approximate_number_of_messags_not_visible, binary}
    | {:created_timestamp, binary}
    | {:last_modified_timestamp, binary}
    | {:queue_arn, binary}
    | {:approximate_number_of_messages_delayed, binary}
    | {:delay_seconds, 0..900}
    | {:receive_message_wait_time_seconds, 0..20}
    | {:redrive_policy, binary}
  ]
  @type sqs_message_attribute :: %{
    :name => binary,
    :data_type => :string | :binary,
    :custom_type => binary | none,
    :value => binary | number
  }

  @doc """
  Adds a permission with the provided label to the Queue
  for a specific action for a specific account.
  """
  defcallback add_permission(queue_url :: binary, label :: binary, permissions :: sqs_acl) :: SQS.Request.response_t

  @doc """
  Extends the read lock timeout for the specified message from
  the specified queue to the specified value
  """
  defcallback change_message_visibility(queue_url :: binary, receipt_handle :: binary, visibility_timeout :: visibility_timeout) :: SQS.Request.response_t

  @doc """
  Extends the read lock timeout for a batch of 1..10 messages
  """
  @type message_visibility_batch_item :: %{
    :id => binary,
    :receipt_handle => binary,
    :visibility_timeout => visibility_timeout
  }
  defcallback change_message_visibility_batch(queue_url :: binary, opts :: [message_visibility_batch_item, ...]) :: SQS.Request.response_t

  @doc "Create queue"
  defcallback create_queue(queue_name :: binary) :: SQS.Request.response_t
  defcallback create_queue(queue_name :: binary, queue_attributes :: queue_attributes) :: SQS.Request.response_t

  @doc "Delete a message from a SQS Queue"
  defcallback delete_message(queue_url :: binary, receipt_handle :: binary) :: SQS.Request.response_t

  @doc "Deletes a list of messages from a SQS Queue in a single request"
  defcallback delete_message_batch(queue_url :: binary, receipt_handles :: [binary, ...]) :: SQS.Request.response_t

  @doc "Delete a queue"
  defcallback delete_queue(queue_url :: binary) :: SQS.Request.response_t

  @doc "Gets attributes of a SQS Queue"
  defcallback get_queue_attributes(queue_url :: binary) :: SQS.Request.response_t
  defcallback get_queue_attributes(queue_url :: binary, attribute_names :: :all | [sqs_queue_attribute_name, ...]) :: SQS.Request.response_t

  @doc "Get queue URL"
  defcallback get_queue_url(queue_name :: binary) :: SQS.Request.response_t
  defcallback get_queue_url(queue_name :: binary, opts :: [queue_owner_aws_account_id: binary]) :: SQS.Request.response_t

  @doc "Retrieves the dead letter source queues for a given SQS Queue"
  defcallback list_dead_letter_source_queues(queue_url :: binary) :: SQS.Request.response_t

  @doc "Retrieves a list of all the SQS Queues"
  defcallback list_queues() :: SQS.Request.response_t
  defcallback list_queues(opts :: [queue_name_prefix: binary]) :: SQS.Request.response_t

  @doc "Purge all messages in a SQS Queue"
  defcallback purge_queue(queue_url :: binary) :: SQS.Request.response_t

  @doc "Read messages from a SQS Queue"
  @type receive_message_opts :: [
    {:attribute_names, :all | [sqs_message_attribute_name, ...]} |
    {:max_number_of_messages, 1..10} |
    {:visibility_timeout, 0..43200} |
    {:wait_timeout, 0..20}
  ]
  defcallback receive_message(queue_name :: binary) :: SQS.Request.response_t
  defcallback receive_message(queue_name :: binary, opts :: receive_message_opts) :: SQS.Request.response_t

  @doc "Removes permission with the given label from the Queue"
  defcallback remove_permission(queue_name :: binary, label :: binary) :: SQS.Request.response_t

  @doc "Send a message to a SQS Queue"
  @type sqs_message_opts :: [
      {:delay_seconds, 0..900} |
      {:attributes, sqs_message_attribute | [sqs_message_attribute, ...]}
  ]
  defcallback send_message(queue_name :: binary, message_body :: binary) :: SQS.Request.response_t
  defcallback send_message(queue_name :: binary, message_body :: binary, opts :: sqs_message_opts) :: SQS.Request.response_t

  @doc "Set attributes of a SQS Queue"
  defcallback set_queue_attributes(queue_name :: binary, attributes :: queue_attributes) :: SQS.Request.response_t

  @doc "Send up to 10 messages to a SQS Queue in a single request"
  @type sqs_batch_message :: binary |
  [
    {:message_body, binary} |
    {:delay_seconds, 0..900} |
    {:attributes, sqs_message_attribute | [sqs_message_attribute, ...]}
  ]
  defcallback send_message_batch(queue_name :: binary, messages :: [sqs_batch_message, ...]) :: SQS.Request.response_t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :sqs
      unquote(boilerplate)

      @doc false
      def request(client, queue_name, action, params) do
        ExAws.SQS.Request.request(client, queue_name, action, params)
      end

      defoverridable config_root: 0, request: 4

    end
  end
end
