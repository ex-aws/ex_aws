defmodule ExAws.SQS.Core do
  @actions [
    "AddPermission",
    "ChangeMessageVisibility",
    "ChangeMessageVisibilityBatch",
    "CreateQueue",
    "DeleteMessage",
    "DeleteMessageBatch",
    "DeleteQueue",
    "GetQueueAttributes",
    "GetQueueUrl",
    "ListDeadLetterSourceQueues",
    "ListQueues",
    "PurgeQueue",
    "ReceiveMessage",
    "RemovePermission",
    "SendMessage",
    "SendMessageBatch",
    "SetQueueAttributes"]

  @moduledoc """
  ## Amazon Simple Queue Service

  Welcome to the *Amazon Simple Queue Service API Reference*. This section
  describes who should read this guide, how the guide is organized, and other
  resources related to the Amazon Simple Queue Service (Amazon SQS).

  Amazon SQS offers reliable and scalable hosted queues for storing messages
  as they travel between computers. By using Amazon SQS, you can move data
  between distributed components of your applications that perform different
  tasks without losing messages or requiring each component to be always
  available.

  Helpful Links:

  - [Current WSDL
  (2012-11-05)](http://queue.amazonaws.com/doc/2012-11-05/QueueService.wsdl)

  - [Making API
  Requests](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/MakingRequestsArticle.html)

  - [Amazon SQS product page](http://aws.amazon.com/sqs/)

  - [Using Amazon SQS Message
  Attributes](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html)

  - [Using Amazon SQS Dead Letter
  Queues](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html)

  - [Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html#sqs_region)

  We also provide SDKs that enable you to access Amazon SQS from your
  preferred programming language. The SDKs contain functionality that
  automatically takes care of tasks such as:

  - Cryptographically signing your service requests

  - Retrying requests

  - Handling error responses

  For a list of available SDKs, go to [Tools for Amazon Web
  Services](http://aws.amazon.com/tools/).
  """

  @type aws_account_id_list :: [binary]

  @type action_name_list :: [binary]

  @type add_permission_request :: [
    aws_account_ids: aws_account_id_list,
    actions: action_name_list,
    label: binary,
    queue_url: binary,
  ]

  @type attribute_map :: [{queue_attribute_name, binary}]

  @type attribute_name_list :: [queue_attribute_name]

  @type batch_entry_ids_not_distinct :: [
  ]

  @type batch_request_too_long :: [
  ]

  @type batch_result_error_entry :: [
    code: binary,
    id: binary,
    message: binary,
    sender_fault: boolean,
  ]

  @type batch_result_error_entry_list :: [batch_result_error_entry]

  @type binary_list :: [binary]

  @type change_message_visibility_batch_request :: [
    entries: change_message_visibility_batch_request_entry_list,
    queue_url: binary,
  ]

  @type change_message_visibility_batch_request_entry :: [
    id: binary,
    receipt_handle: binary,
    visibility_timeout: integer,
  ]

  @type change_message_visibility_batch_request_entry_list :: [change_message_visibility_batch_request_entry]

  @type change_message_visibility_batch_result :: [
    failed: batch_result_error_entry_list,
    successful: change_message_visibility_batch_result_entry_list,
  ]

  @type change_message_visibility_batch_result_entry :: [
    id: binary,
  ]

  @type change_message_visibility_batch_result_entry_list :: [change_message_visibility_batch_result_entry]

  @type change_message_visibility_request :: [
    queue_url: binary,
    receipt_handle: binary,
    visibility_timeout: integer,
  ]

  @type create_queue_request :: [
    attributes: attribute_map,
    queue_name: binary,
  ]

  @type create_queue_result :: [
    queue_url: binary,
  ]

  @type delete_message_batch_request :: [
    entries: delete_message_batch_request_entry_list,
    queue_url: binary,
  ]

  @type delete_message_batch_request_entry :: [
    id: binary,
    receipt_handle: binary,
  ]

  @type delete_message_batch_request_entry_list :: [delete_message_batch_request_entry]

  @type delete_message_batch_result :: [
    failed: batch_result_error_entry_list,
    successful: delete_message_batch_result_entry_list,
  ]

  @type delete_message_batch_result_entry :: [
    id: binary,
  ]

  @type delete_message_batch_result_entry_list :: [delete_message_batch_result_entry]

  @type delete_message_request :: [
    queue_url: binary,
    receipt_handle: binary,
  ]

  @type delete_queue_request :: [
    queue_url: binary,
  ]

  @type empty_batch_request :: [
  ]

  @type get_queue_attributes_request :: [
    attribute_names: attribute_name_list,
    queue_url: binary,
  ]

  @type get_queue_attributes_result :: [
    attributes: attribute_map,
  ]

  @type get_queue_url_request :: [
    queue_name: binary,
    queue_owner_aws_account_id: binary,
  ]

  @type get_queue_url_result :: [
    queue_url: binary,
  ]

  @type invalid_attribute_name :: [
  ]

  @type invalid_batch_entry_id :: [
  ]

  @type invalid_id_format :: [
  ]

  @type invalid_message_contents :: [
  ]

  @type list_dead_letter_source_queues_request :: [
    queue_url: binary,
  ]

  @type list_dead_letter_source_queues_result :: [
    queue_urls: queue_url_list,
  ]

  @type list_queues_request :: [
    queue_name_prefix: binary,
  ]

  @type list_queues_result :: [
    queue_urls: queue_url_list,
  ]

  @type message :: [
    attributes: attribute_map,
    body: binary,
    m_d5_of_body: binary,
    m_d5_of_message_attributes: binary,
    message_attributes: message_attribute_map,
    message_id: binary,
    receipt_handle: binary,
  ]

  @type message_attribute_map :: [{binary, message_attribute_value}]

  @type message_attribute_name :: binary

  @type message_attribute_name_list :: [message_attribute_name]

  @type message_attribute_value :: [
    binary_list_values: binary_list,
    binary_value: binary,
    data_type: binary,
    string_list_values: string_list,
    string_value: binary,
  ]

  @type message_list :: [message]

  @type message_not_inflight :: [
  ]

  @type over_limit :: [
  ]

  @type purge_queue_in_progress :: [
  ]

  @type purge_queue_request :: [
    queue_url: binary,
  ]

  @type queue_attribute_name :: binary

  @type queue_deleted_recently :: [
  ]

  @type queue_does_not_exist :: [
  ]

  @type queue_name_exists :: [
  ]

  @type queue_url_list :: [binary]

  @type receipt_handle_is_invalid :: [
  ]

  @type receive_message_request :: [
    attribute_names: attribute_name_list,
    max_number_of_messages: integer,
    message_attribute_names: message_attribute_name_list,
    queue_url: binary,
    visibility_timeout: integer,
    wait_time_seconds: integer,
  ]

  @type receive_message_result :: [
    messages: message_list,
  ]

  @type remove_permission_request :: [
    label: binary,
    queue_url: binary,
  ]

  @type send_message_batch_request :: [
    entries: send_message_batch_request_entry_list,
    queue_url: binary,
  ]

  @type send_message_batch_request_entry :: [
    delay_seconds: integer,
    id: binary,
    message_attributes: message_attribute_map,
    message_body: binary,
  ]

  @type send_message_batch_request_entry_list :: [send_message_batch_request_entry]

  @type send_message_batch_result :: [
    failed: batch_result_error_entry_list,
    successful: send_message_batch_result_entry_list,
  ]

  @type send_message_batch_result_entry :: [
    id: binary,
    m_d5_of_message_attributes: binary,
    m_d5_of_message_body: binary,
    message_id: binary,
  ]

  @type send_message_batch_result_entry_list :: [send_message_batch_result_entry]

  @type send_message_request :: [
    delay_seconds: integer,
    message_attributes: message_attribute_map,
    message_body: binary,
    queue_url: binary,
  ]

  @type send_message_result :: [
    m_d5_of_message_attributes: binary,
    m_d5_of_message_body: binary,
    message_id: binary,
  ]

  @type set_queue_attributes_request :: [
    attributes: attribute_map,
    queue_url: binary,
  ]

  @type string_list :: [binary]

  @type too_many_entries_in_batch_request :: [
  ]

  @type unsupported_operation :: [
  ]




  @doc """
  AddPermission

  Adds a permission to a queue for a specific
  [principal](http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P).
  This allows for sharing access to the queue.

  When you create a queue, you have full control access rights for the queue.
  Only you (as owner of the queue) can grant or deny permissions to the
  queue. For more information about these permissions, see [Shared
  Queues](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html)
  in the *Amazon SQS Developer Guide*.

  Note: `AddPermission` writes an Amazon SQS-generated policy. If you want to
  write your own policy, use `SetQueueAttributes` to upload your policy. For
  more information about writing your own policy, see [Using The Access
  Policy
  Language](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AccessPolicyLanguage.html)
  in the *Amazon SQS Developer Guide*.

  Note:Some API actions take lists of parameters. These lists are specified
  using the `param.n` notation. Values of `n` are integers starting from 1.
  For example, a parameter list with two elements looks like this:
  `&amp;Attribute.1=this`

  `&amp;Attribute.2=that`
  """

  @spec add_permission(client :: ExAws.SQS.t, input :: add_permission_request) :: ExAws.Request.Query.response_t
  def add_permission(client, input) do
    request(client, "/", "AddPermission", input)
  end

  @doc """
  Same as `add_permission/2` but raise on error.
  """
  @spec add_permission!(client :: ExAws.SQS.t, input :: add_permission_request) :: ExAws.Request.Query.success_t | no_return
  def add_permission!(client, input) do
    case add_permission(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ChangeMessageVisibility

  Changes the visibility timeout of a specified message in a queue to a new
  value. The maximum allowed timeout value you can set the value to is 12
  hours. This means you can't extend the timeout of a message in an existing
  queue to more than a total visibility timeout of 12 hours. (For more
  information visibility timeout, see [Visibility
  Timeout](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html)
  in the *Amazon SQS Developer Guide*.)

  For example, let's say you have a message and its default message
  visibility timeout is 30 minutes. You could call `ChangeMessageVisiblity`
  with a value of two hours and the effective timeout would be two hours and
  30 minutes. When that time comes near you could again extend the time out
  by calling ChangeMessageVisiblity, but this time the maximum allowed
  timeout would be 9 hours and 30 minutes.

  Note:There is a 120,000 limit for the number of inflight messages per
  queue. Messages are inflight after they have been received from the queue
  by a consuming component, but have not yet been deleted from the queue. If
  you reach the 120,000 limit, you will receive an OverLimit error message
  from Amazon SQS. To help avoid reaching the limit, you should delete the
  messages from the queue after they have been processed. You can also
  increase the number of queues you use to process the messages.

  **If you attempt to set the `VisibilityTimeout` to an amount more than the
  maximum time left, Amazon SQS returns an error. It will not automatically
  recalculate and increase the timeout to the maximum time remaining.**
  **Unlike with a queue, when you change the visibility timeout for a
  specific message, that timeout value is applied immediately but is not
  saved in memory for that message. If you don't delete a message after it is
  received, the visibility timeout for the message the next time it is
  received reverts to the original timeout value, not the value you set with
  the `ChangeMessageVisibility` action.**
  """

  @spec change_message_visibility(client :: ExAws.SQS.t, input :: change_message_visibility_request) :: ExAws.Request.Query.response_t
  def change_message_visibility(client, input) do
    request(client, "/", "ChangeMessageVisibility", input)
  end

  @doc """
  Same as `change_message_visibility/2` but raise on error.
  """
  @spec change_message_visibility!(client :: ExAws.SQS.t, input :: change_message_visibility_request) :: ExAws.Request.Query.success_t | no_return
  def change_message_visibility!(client, input) do
    case change_message_visibility(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ChangeMessageVisibilityBatch

  Changes the visibility timeout of multiple messages. This is a batch
  version of `ChangeMessageVisibility`. The result of the action on each
  message is reported individually in the response. You can send up to 10
  `ChangeMessageVisibility` requests with each `ChangeMessageVisibilityBatch`
  action.

  **Because the batch request can result in a combination of successful and
  unsuccessful actions, you should check for batch errors even when the call
  returns an HTTP status code of 200.** Note:Some API actions take lists of
  parameters. These lists are specified using the `param.n` notation. Values
  of `n` are integers starting from 1. For example, a parameter list with two
  elements looks like this: `&amp;Attribute.1=this`

  `&amp;Attribute.2=that`
  """

  @spec change_message_visibility_batch(client :: ExAws.SQS.t, input :: change_message_visibility_batch_request) :: ExAws.Request.Query.response_t
  def change_message_visibility_batch(client, input) do
    request(client, "/", "ChangeMessageVisibilityBatch", input)
  end

  @doc """
  Same as `change_message_visibility_batch/2` but raise on error.
  """
  @spec change_message_visibility_batch!(client :: ExAws.SQS.t, input :: change_message_visibility_batch_request) :: ExAws.Request.Query.success_t | no_return
  def change_message_visibility_batch!(client, input) do
    case change_message_visibility_batch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateQueue

  Creates a new queue, or returns the URL of an existing one. When you
  request `CreateQueue`, you provide a name for the queue. To successfully
  create a new queue, you must provide a name that is unique within the scope
  of your own queues.

  Note: If you delete a queue, you must wait at least 60 seconds before
  creating a queue with the same name.

  You may pass one or more attributes in the request. If you do not provide a
  value for any attribute, the queue will have the default value for that
  attribute. Permitted attributes are the same that can be set using
  `SetQueueAttributes`.

  Note:Use `GetQueueUrl` to get a queue's URL. `GetQueueUrl` requires only
  the `QueueName` parameter.

  If you provide the name of an existing queue, along with the exact names
  and values of all the queue's attributes, `CreateQueue` returns the queue
  URL for the existing queue. If the queue name, attribute names, or
  attribute values do not match an existing queue, `CreateQueue` returns an
  error.

  Note:Some API actions take lists of parameters. These lists are specified
  using the `param.n` notation. Values of `n` are integers starting from 1.
  For example, a parameter list with two elements looks like this:
  `&amp;Attribute.1=this`

  `&amp;Attribute.2=that`
  """

  @spec create_queue(client :: ExAws.SQS.t, input :: create_queue_request) :: ExAws.Request.Query.response_t
  def create_queue(client, input) do
    request(client, "/", "CreateQueue", input)
  end

  @doc """
  Same as `create_queue/2` but raise on error.
  """
  @spec create_queue!(client :: ExAws.SQS.t, input :: create_queue_request) :: ExAws.Request.Query.success_t | no_return
  def create_queue!(client, input) do
    case create_queue(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteMessage

  Deletes the specified message from the specified queue. You specify the
  message by using the message's `receipt handle` and not the `message ID`
  you received when you sent the message. Even if the message is locked by
  another reader due to the visibility timeout setting, it is still deleted
  from the queue. If you leave a message in the queue for longer than the
  queue's configured retention period, Amazon SQS automatically deletes it.

  Note: The receipt handle is associated with a specific instance of
  receiving the message. If you receive a message more than once, the receipt
  handle you get each time you receive the message is different. When you
  request `DeleteMessage`, if you don't provide the most recently received
  receipt handle for the message, the request will still succeed, but the
  message might not be deleted.

  ** It is possible you will receive a message even after you have deleted
  it. This might happen on rare occasions if one of the servers storing a
  copy of the message is unavailable when you request to delete the message.
  The copy remains on the server and might be returned to you again on a
  subsequent receive request. You should create your system to be idempotent
  so that receiving a particular message more than once is not a problem.

  **
  """

  @spec delete_message(client :: ExAws.SQS.t, input :: delete_message_request) :: ExAws.Request.Query.response_t
  def delete_message(client, input) do
    request(client, "/", "DeleteMessage", input)
  end

  @doc """
  Same as `delete_message/2` but raise on error.
  """
  @spec delete_message!(client :: ExAws.SQS.t, input :: delete_message_request) :: ExAws.Request.Query.success_t | no_return
  def delete_message!(client, input) do
    case delete_message(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteMessageBatch

  Deletes up to ten messages from the specified queue. This is a batch
  version of `DeleteMessage`. The result of the delete action on each message
  is reported individually in the response.

  ** Because the batch request can result in a combination of successful and
  unsuccessful actions, you should check for batch errors even when the call
  returns an HTTP status code of 200.

  ** Note:Some API actions take lists of parameters. These lists are
  specified using the `param.n` notation. Values of `n` are integers starting
  from 1. For example, a parameter list with two elements looks like this:
  `&amp;Attribute.1=this`

  `&amp;Attribute.2=that`
  """

  @spec delete_message_batch(client :: ExAws.SQS.t, input :: delete_message_batch_request) :: ExAws.Request.Query.response_t
  def delete_message_batch(client, input) do
    request(client, "/", "DeleteMessageBatch", input)
  end

  @doc """
  Same as `delete_message_batch/2` but raise on error.
  """
  @spec delete_message_batch!(client :: ExAws.SQS.t, input :: delete_message_batch_request) :: ExAws.Request.Query.success_t | no_return
  def delete_message_batch!(client, input) do
    case delete_message_batch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteQueue

  Deletes the queue specified by the **queue URL**, regardless of whether the
  queue is empty. If the specified queue does not exist, Amazon SQS returns a
  successful response.

  ** Use `DeleteQueue` with care; once you delete your queue, any messages in
  the queue are no longer available.

  ** When you delete a queue, the deletion process takes up to 60 seconds.
  Requests you send involving that queue during the 60 seconds might succeed.
  For example, a `SendMessage` request might succeed, but after the 60
  seconds, the queue and that message you sent no longer exist. Also, when
  you delete a queue, you must wait at least 60 seconds before creating a
  queue with the same name.

  We reserve the right to delete queues that have had no activity for more
  than 30 days. For more information, see [How Amazon SQS Queues
  Work](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSConcepts.html)
  in the *Amazon SQS Developer Guide*.
  """

  @spec delete_queue(client :: ExAws.SQS.t, input :: delete_queue_request) :: ExAws.Request.Query.response_t
  def delete_queue(client, input) do
    request(client, "/", "DeleteQueue", input)
  end

  @doc """
  Same as `delete_queue/2` but raise on error.
  """
  @spec delete_queue!(client :: ExAws.SQS.t, input :: delete_queue_request) :: ExAws.Request.Query.success_t | no_return
  def delete_queue!(client, input) do
    case delete_queue(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetQueueAttributes

  Gets attributes for the specified queue. The following attributes are
  supported:

  - `All` - returns all values.

  - `ApproximateNumberOfMessages` - returns the approximate number of visible
  messages in a queue. For more information, see [Resources Required to
  Process
  Messages](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html)
  in the *Amazon SQS Developer Guide*.

  - `ApproximateNumberOfMessagesNotVisible` - returns the approximate number
  of messages that are not timed-out and not deleted. For more information,
  see [Resources Required to Process
  Messages](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html)
  in the *Amazon SQS Developer Guide*.

  - `VisibilityTimeout` - returns the visibility timeout for the queue. For
  more information about visibility timeout, see [Visibility
  Timeout](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html)
  in the *Amazon SQS Developer Guide*.

  - `CreatedTimestamp` - returns the time when the queue was created (epoch
  time in seconds).

  - `LastModifiedTimestamp` - returns the time when the queue was last
  changed (epoch time in seconds).

  - `Policy` - returns the queue's policy.

  - `MaximumMessageSize` - returns the limit of how many bytes a message can
  contain before Amazon SQS rejects it.

  - `MessageRetentionPeriod` - returns the number of seconds Amazon SQS
  retains a message.

  - `QueueArn` - returns the queue's Amazon resource name (ARN).

  - `ApproximateNumberOfMessagesDelayed` - returns the approximate number of
  messages that are pending to be added to the queue.

  - `DelaySeconds` - returns the default delay on the queue in seconds.

  - `ReceiveMessageWaitTimeSeconds` - returns the time for which a
  ReceiveMessage call will wait for a message to arrive.

  - `RedrivePolicy` - returns the parameters for dead letter queue
  functionality of the source queue. For more information about RedrivePolicy
  and dead letter queues, see [Using Amazon SQS Dead Letter
  Queues](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html)
  in the *Amazon SQS Developer Guide*.

  Note:Going forward, new attributes might be added. If you are writing code
  that calls this action, we recommend that you structure your code so that
  it can handle new attributes gracefully. Note:Some API actions take lists
  of parameters. These lists are specified using the `param.n` notation.
  Values of `n` are integers starting from 1. For example, a parameter list
  with two elements looks like this: `&amp;Attribute.1=this`

  `&amp;Attribute.2=that`
  """

  @spec get_queue_attributes(client :: ExAws.SQS.t, input :: get_queue_attributes_request) :: ExAws.Request.Query.response_t
  def get_queue_attributes(client, input) do
    request(client, "/", "GetQueueAttributes", input)
  end

  @doc """
  Same as `get_queue_attributes/2` but raise on error.
  """
  @spec get_queue_attributes!(client :: ExAws.SQS.t, input :: get_queue_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def get_queue_attributes!(client, input) do
    case get_queue_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetQueueUrl

  Returns the URL of an existing queue. This action provides a simple way to
  retrieve the URL of an Amazon SQS queue.

  To access a queue that belongs to another AWS account, use the
  `QueueOwnerAWSAccountId` parameter to specify the account ID of the queue's
  owner. The queue's owner must grant you permission to access the queue. For
  more information about shared queue access, see `AddPermission` or go to
  [Shared
  Queues](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html)
  in the *Amazon SQS Developer Guide*.
  """

  @spec get_queue_url(client :: ExAws.SQS.t, input :: get_queue_url_request) :: ExAws.Request.Query.response_t
  def get_queue_url(client, input) do
    request(client, "/", "GetQueueUrl", input)
  end

  @doc """
  Same as `get_queue_url/2` but raise on error.
  """
  @spec get_queue_url!(client :: ExAws.SQS.t, input :: get_queue_url_request) :: ExAws.Request.Query.success_t | no_return
  def get_queue_url!(client, input) do
    case get_queue_url(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDeadLetterSourceQueues

  Returns a list of your queues that have the RedrivePolicy queue attribute
  configured with a dead letter queue.

  For more information about using dead letter queues, see [Using Amazon SQS
  Dead Letter
  Queues](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html).
  """

  @spec list_dead_letter_source_queues(client :: ExAws.SQS.t, input :: list_dead_letter_source_queues_request) :: ExAws.Request.Query.response_t
  def list_dead_letter_source_queues(client, input) do
    request(client, "/", "ListDeadLetterSourceQueues", input)
  end

  @doc """
  Same as `list_dead_letter_source_queues/2` but raise on error.
  """
  @spec list_dead_letter_source_queues!(client :: ExAws.SQS.t, input :: list_dead_letter_source_queues_request) :: ExAws.Request.Query.success_t | no_return
  def list_dead_letter_source_queues!(client, input) do
    case list_dead_letter_source_queues(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListQueues

  Returns a list of your queues. The maximum number of queues that can be
  returned is 1000. If you specify a value for the optional `QueueNamePrefix`
  parameter, only queues with a name beginning with the specified value are
  returned.
  """

  @spec list_queues(client :: ExAws.SQS.t, input :: list_queues_request) :: ExAws.Request.Query.response_t
  def list_queues(client, input) do
    request(client, "/", "ListQueues", input)
  end

  @doc """
  Same as `list_queues/2` but raise on error.
  """
  @spec list_queues!(client :: ExAws.SQS.t, input :: list_queues_request) :: ExAws.Request.Query.success_t | no_return
  def list_queues!(client, input) do
    case list_queues(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PurgeQueue

  Deletes the messages in a queue specified by the **queue URL**.

  **When you use the `PurgeQueue` API, the deleted messages in the queue
  cannot be retrieved.** When you purge a queue, the message deletion process
  takes up to 60 seconds. All messages sent to the queue before calling
  `PurgeQueue` will be deleted; messages sent to the queue while it is being
  purged may be deleted. While the queue is being purged, messages sent to
  the queue before `PurgeQueue` was called may be received, but will be
  deleted within the next minute.
  """

  @spec purge_queue(client :: ExAws.SQS.t, input :: purge_queue_request) :: ExAws.Request.Query.response_t
  def purge_queue(client, input) do
    request(client, "/", "PurgeQueue", input)
  end

  @doc """
  Same as `purge_queue/2` but raise on error.
  """
  @spec purge_queue!(client :: ExAws.SQS.t, input :: purge_queue_request) :: ExAws.Request.Query.success_t | no_return
  def purge_queue!(client, input) do
    case purge_queue(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ReceiveMessage

  Retrieves one or more messages, with a maximum limit of 10 messages, from
  the specified queue. Long poll support is enabled by using the
  `WaitTimeSeconds` parameter. For more information, see [Amazon SQS Long
  Poll](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-long-polling.html)
  in the *Amazon SQS Developer Guide*.

  Short poll is the default behavior where a weighted random set of machines
  is sampled on a `ReceiveMessage` call. This means only the messages on the
  sampled machines are returned. If the number of messages in the queue is
  small (less than 1000), it is likely you will get fewer messages than you
  requested per `ReceiveMessage` call. If the number of messages in the queue
  is extremely small, you might not receive any messages in a particular
  `ReceiveMessage` response; in which case you should repeat the request.

  For each message returned, the response includes the following:

  - Message body

  - MD5 digest of the message body. For information about MD5, go to
  [http://www.faqs.org/rfcs/rfc1321.html](http://www.faqs.org/rfcs/rfc1321.html).

  - Message ID you received when you sent the message to the queue.

  - Receipt handle.

  - Message attributes.

  - MD5 digest of the message attributes.

  The receipt handle is the identifier you must provide when deleting the
  message. For more information, see [Queue and Message
  Identifiers](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html)
  in the *Amazon SQS Developer Guide*.

  You can provide the `VisibilityTimeout` parameter in your request, which
  will be applied to the messages that Amazon SQS returns in the response. If
  you do not include the parameter, the overall visibility timeout for the
  queue is used for the returned messages. For more information, see
  [Visibility
  Timeout](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html)
  in the *Amazon SQS Developer Guide*.

  Note: Going forward, new attributes might be added. If you are writing code
  that calls this action, we recommend that you structure your code so that
  it can handle new attributes gracefully.
  """

  @spec receive_message(client :: ExAws.SQS.t, input :: receive_message_request) :: ExAws.Request.Query.response_t
  def receive_message(client, input) do
    request(client, "/", "ReceiveMessage", input)
  end

  @doc """
  Same as `receive_message/2` but raise on error.
  """
  @spec receive_message!(client :: ExAws.SQS.t, input :: receive_message_request) :: ExAws.Request.Query.success_t | no_return
  def receive_message!(client, input) do
    case receive_message(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemovePermission

  Revokes any permissions in the queue policy that matches the specified
  `Label` parameter. Only the owner of the queue can remove permissions.
  """

  @spec remove_permission(client :: ExAws.SQS.t, input :: remove_permission_request) :: ExAws.Request.Query.response_t
  def remove_permission(client, input) do
    request(client, "/", "RemovePermission", input)
  end

  @doc """
  Same as `remove_permission/2` but raise on error.
  """
  @spec remove_permission!(client :: ExAws.SQS.t, input :: remove_permission_request) :: ExAws.Request.Query.success_t | no_return
  def remove_permission!(client, input) do
    case remove_permission(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SendMessage

  Delivers a message to the specified queue. With Amazon SQS, you now have
  the ability to send large payload messages that are up to 256KB (262,144
  bytes) in size. To send large payloads, you must use an AWS SDK that
  supports SigV4 signing. To verify whether SigV4 is supported for an AWS
  SDK, check the SDK release notes.

  ** The following list shows the characters (in Unicode) allowed in your
  message, according to the W3C XML specification. For more information, go
  to
  [http://www.w3.org/TR/REC-xml/#charsets](http://www.w3.org/TR/REC-xml/#charsets)
  If you send any characters not included in the list, your request will be
  rejected.

  #x9 | #xA | #xD | [#x20 to #xD7FF] | [#xE000 to #xFFFD] | [#x10000 to
  #x10FFFF]

  **
  """

  @spec send_message(client :: ExAws.SQS.t, input :: send_message_request) :: ExAws.Request.Query.response_t
  def send_message(client, input) do
    request(client, "/", "SendMessage", input)
  end

  @doc """
  Same as `send_message/2` but raise on error.
  """
  @spec send_message!(client :: ExAws.SQS.t, input :: send_message_request) :: ExAws.Request.Query.success_t | no_return
  def send_message!(client, input) do
    case send_message(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SendMessageBatch

  Delivers up to ten messages to the specified queue. This is a batch version
  of `SendMessage`. The result of the send action on each message is reported
  individually in the response. The maximum allowed individual message size
  is 256 KB (262,144 bytes).

  The maximum total payload size (i.e., the sum of all a batch's individual
  message lengths) is also 256 KB (262,144 bytes).

  If the `DelaySeconds` parameter is not specified for an entry, the default
  for the queue is used.

  **The following list shows the characters (in Unicode) that are allowed in
  your message, according to the W3C XML specification. For more information,
  go to
  [http://www.faqs.org/rfcs/rfc1321.html](http://www.faqs.org/rfcs/rfc1321.html).
  If you send any characters that are not included in the list, your request
  will be rejected. #x9 | #xA | #xD | [#x20 to #xD7FF] | [#xE000 to #xFFFD] |
  [#x10000 to #x10FFFF]

  ** ** Because the batch request can result in a combination of successful
  and unsuccessful actions, you should check for batch errors even when the
  call returns an HTTP status code of 200. ** Note:Some API actions take
  lists of parameters. These lists are specified using the `param.n`
  notation. Values of `n` are integers starting from 1. For example, a
  parameter list with two elements looks like this: `&amp;Attribute.1=this`

  `&amp;Attribute.2=that`
  """

  @spec send_message_batch(client :: ExAws.SQS.t, input :: send_message_batch_request) :: ExAws.Request.Query.response_t
  def send_message_batch(client, input) do
    request(client, "/", "SendMessageBatch", input)
  end

  @doc """
  Same as `send_message_batch/2` but raise on error.
  """
  @spec send_message_batch!(client :: ExAws.SQS.t, input :: send_message_batch_request) :: ExAws.Request.Query.success_t | no_return
  def send_message_batch!(client, input) do
    case send_message_batch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetQueueAttributes

  Sets the value of one or more queue attributes. When you change a queue's
  attributes, the change can take up to 60 seconds for most of the attributes
  to propagate throughout the SQS system. Changes made to the
  `MessageRetentionPeriod` attribute can take up to 15 minutes.

  Note:Going forward, new attributes might be added. If you are writing code
  that calls this action, we recommend that you structure your code so that
  it can handle new attributes gracefully.
  """

  @spec set_queue_attributes(client :: ExAws.SQS.t, input :: set_queue_attributes_request) :: ExAws.Request.Query.response_t
  def set_queue_attributes(client, input) do
    request(client, "/", "SetQueueAttributes", input)
  end

  @doc """
  Same as `set_queue_attributes/2` but raise on error.
  """
  @spec set_queue_attributes!(client :: ExAws.SQS.t, input :: set_queue_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def set_queue_attributes!(client, input) do
    case set_queue_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
