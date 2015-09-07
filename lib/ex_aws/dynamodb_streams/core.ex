defmodule ExAws.Dynamodb.Streams.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "DescribeStream",
    "GetRecords",
    "GetShardIterator",
    "ListStreams"]

  @moduledoc """
  ## Amazon DynamoDB Streams

  Amazon DynamoDB Streams

  This is the Amazon DynamoDB Streams API Reference. This guide describes the
  low-level API actions for accessing streams and processing stream records.
  For information about application development with DynamoDB Streams, see
  the [Amazon DynamoDB Developer
  Guide](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide//Streams.html).

  Note that this document is intended for use with the following DynamoDB
  documentation:

  - [Amazon DynamoDB Developer
  Guide](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/)

  - [Amazon DynamoDB API
  Reference](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/)

  The following are short descriptions of each low-level DynamoDB Streams API
  action, organized by function.

  - *DescribeStream* - Returns detailed information about a particular
  stream.

  - *GetRecords* - Retrieves the stream records from within a shard.

  - *GetShardIterator* - Returns information on how to retrieve the streams
  record from a shard with a given shard ID.

  - *ListStreams* - Returns a list of all the streams associated with the
  current AWS account and endpoint.
  """

  @type attribute_map :: [{attribute_name, attribute_value}]

  @type attribute_name :: binary

  @type attribute_value :: [
    b: binary_attribute_value,
    bool: boolean_attribute_value,
    bs: binary_set_attribute_value,
    l: list_attribute_value,
    m: map_attribute_value,
    n: number_attribute_value,
    ns: number_set_attribute_value,
    null: null_attribute_value,
    s: string_attribute_value,
    ss: string_set_attribute_value,
  ]

  @type binary_attribute_value :: binary

  @type binary_set_attribute_value :: [binary_attribute_value]

  @type boolean_attribute_value :: boolean

  @type date :: integer

  @type describe_stream_input :: [
    exclusive_start_shard_id: shard_id,
    limit: positive_integer_object,
    stream_arn: stream_arn,
  ]

  @type describe_stream_output :: [
    stream_description: stream_description,
  ]

  @type error_message :: binary

  @type expired_iterator_exception :: [
    message: error_message,
  ]

  @type get_records_input :: [
    limit: positive_integer_object,
    shard_iterator: shard_iterator,
  ]

  @type get_records_output :: [
    next_shard_iterator: shard_iterator,
    records: record_list,
  ]

  @type get_shard_iterator_input :: [
    sequence_number: sequence_number,
    shard_id: shard_id,
    shard_iterator_type: shard_iterator_type,
    stream_arn: stream_arn,
  ]

  @type get_shard_iterator_output :: [
    shard_iterator: shard_iterator,
  ]

  @type internal_server_error :: [
    message: error_message,
  ]

  @type key_schema :: [key_schema_element]

  @type key_schema_attribute_name :: binary

  @type key_schema_element :: [
    attribute_name: key_schema_attribute_name,
    key_type: key_type,
  ]

  @type key_type :: binary

  @type limit_exceeded_exception :: [
    message: error_message,
  ]

  @type list_attribute_value :: [attribute_value]

  @type list_streams_input :: [
    exclusive_start_stream_arn: stream_arn,
    limit: positive_integer_object,
    table_name: table_name,
  ]

  @type list_streams_output :: [
    last_evaluated_stream_arn: stream_arn,
    streams: stream_list,
  ]

  @type map_attribute_value :: [{attribute_name, attribute_value}]

  @type null_attribute_value :: boolean

  @type number_attribute_value :: binary

  @type number_set_attribute_value :: [number_attribute_value]

  @type operation_type :: binary

  @type positive_integer_object :: integer

  @type positive_long_object :: integer

  @type dynamodb_streams_record :: [
    aws_region: binary,
    dynamodb: stream_record,
    event_id: binary,
    event_name: operation_type,
    event_source: binary,
    event_version: binary,
  ]

  @type record_list :: [dynamodb_streams_record]

  @type resource_not_found_exception :: [
    message: error_message,
  ]

  @type sequence_number :: binary

  @type sequence_number_range :: [
    ending_sequence_number: sequence_number,
    starting_sequence_number: sequence_number,
  ]

  @type shard :: [
    parent_shard_id: shard_id,
    sequence_number_range: sequence_number_range,
    shard_id: shard_id,
  ]

  @type shard_description_list :: [shard]

  @type shard_id :: binary

  @type shard_iterator :: binary

  @type shard_iterator_type :: binary

  @type stream :: [
    stream_arn: stream_arn,
    stream_label: binary,
    table_name: table_name,
  ]

  @type stream_arn :: binary

  @type stream_description :: [
    creation_request_date_time: date,
    key_schema: key_schema,
    last_evaluated_shard_id: shard_id,
    shards: shard_description_list,
    stream_arn: stream_arn,
    stream_label: binary,
    stream_status: stream_status,
    stream_view_type: stream_view_type,
    table_name: table_name,
  ]

  @type stream_list :: [stream]

  @type stream_record :: [
    keys: attribute_map,
    new_image: attribute_map,
    old_image: attribute_map,
    sequence_number: sequence_number,
    size_bytes: positive_long_object,
    stream_view_type: stream_view_type,
  ]

  @type stream_status :: binary

  @type stream_view_type :: binary

  @type string_attribute_value :: binary

  @type string_set_attribute_value :: [string_attribute_value]

  @type table_name :: binary

  @type trimmed_data_access_exception :: [
    message: error_message,
  ]





  @doc """
  DescribeStream

  Returns information about a stream, including the current status of the
  stream, its Amazon Resource Name (ARN), the composition of its shards, and
  its corresponding DynamoDB table.

  Note:You can call *DescribeStream* at a maximum rate of 10 times per
  second.

  Each shard in the stream has a `SequenceNumberRange` associated with it. If
  the `SequenceNumberRange` has a `StartingSequenceNumber` but no
  `EndingSequenceNumber`, then the shard is still open (able to receive more
  stream records). If both `StartingSequenceNumber` and
  `EndingSequenceNumber` are present, the that shared is closed and can no
  longer receive more data.
  """

  @spec describe_stream(client :: ExAws.Dynamodb.Streams.t, input :: describe_stream_input) :: ExAws.Request.JSON.response_t
  def describe_stream(client, input) do
    request(client, "DescribeStream", format_input(input))
  end

  @doc """
  Same as `describe_stream/2` but raise on error.
  """
  @spec describe_stream!(client :: ExAws.Dynamodb.Streams.t, input :: describe_stream_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_stream!(client, input) do
    case describe_stream(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetRecords

  Retrieves the stream records from a given shard.

  Specify a shard iterator using the `ShardIterator` parameter. The shard
  iterator specifies the position in the shard from which you want to start
  reading stream records sequentially. If there are no stream records
  available in the portion of the shard that the iterator points to,
  `GetRecords` returns an empty list. Note that it might take multiple calls
  to get to a portion of the shard that contains stream records.

  Note:<function>GetRecords</function> can retrieve a maximum of 1 MB of data
  or 2000 stream records, whichever comes first.
  """

  @spec get_records(client :: ExAws.Dynamodb.Streams.t, input :: get_records_input) :: ExAws.Request.JSON.response_t
  def get_records(client, input) do
    request(client, "GetRecords", format_input(input))
  end

  @doc """
  Same as `get_records/2` but raise on error.
  """
  @spec get_records!(client :: ExAws.Dynamodb.Streams.t, input :: get_records_input) :: ExAws.Request.JSON.success_t | no_return
  def get_records!(client, input) do
    case get_records(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetShardIterator

  Returns a shard iterator. A shard iterator provides information about how
  to retrieve the stream records from within a shard. Use the shard iterator
  in a subsequent `GetRecords` request to read the stream records from the
  shard.

  Note:A shard iterator expires 15 minutes after it is returned to the
  requester.
  """

  @spec get_shard_iterator(client :: ExAws.Dynamodb.Streams.t, input :: get_shard_iterator_input) :: ExAws.Request.JSON.response_t
  def get_shard_iterator(client, input) do
    request(client, "GetShardIterator", format_input(input))
  end

  @doc """
  Same as `get_shard_iterator/2` but raise on error.
  """
  @spec get_shard_iterator!(client :: ExAws.Dynamodb.Streams.t, input :: get_shard_iterator_input) :: ExAws.Request.JSON.success_t | no_return
  def get_shard_iterator!(client, input) do
    case get_shard_iterator(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListStreams

  Returns an array of stream ARNs associated with the current account and
  endpoint. If the `TableName` parameter is present, then *ListStreams* will
  return only the streams ARNs for that table.

  Note:You can call *ListStreams* at a maximum rate of 5 times per second.
  """

  @spec list_streams(client :: ExAws.Dynamodb.Streams.t, input :: list_streams_input) :: ExAws.Request.JSON.response_t
  def list_streams(client, input) do
    request(client, "ListStreams", format_input(input))
  end

  @doc """
  Same as `list_streams/2` but raise on error.
  """
  @spec list_streams!(client :: ExAws.Dynamodb.Streams.t, input :: list_streams_input) :: ExAws.Request.JSON.success_t | no_return
  def list_streams!(client, input) do
    case list_streams(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
