defmodule ExAws.SQS.ParserTest do
  use ExUnit.Case, async: true
  import Support.ParserHelpers

  alias ExAws.SQS.Parsers

  test "#parsing a list queue response" do
    rsp = """
    <ListQueuesResponse>
      <ListQueuesResult>
        <QueueUrl>http://sqs.us-east-1.amazonaws.com/123456789012/testQueue</QueueUrl>
      </ListQueuesResult>
      <ResponseMetadata>
        <RequestId>725275ae-0b9b-4762-b238-436d7c65a1ac</RequestId>
      </ResponseMetadata>
    </ListQueuesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_queues)
    assert parsed_doc[:queues] == ["http://sqs.us-east-1.amazonaws.com/123456789012/testQueue"]
    assert parsed_doc[:request_id] == "725275ae-0b9b-4762-b238-436d7c65a1ac"
  end

  test "parsing a create queue response" do
    rsp = """
    <CreateQueueResponse>
      <CreateQueueResult>
        <QueueUrl>http://queue.amazonaws.com/123456789012/testQueue</QueueUrl>
      </CreateQueueResult>
      <ResponseMetadata>
        <RequestId>7a62c49f-347e-4fc4-9331-6e8e7a96aa73</RequestId>
      </ResponseMetadata>
    </CreateQueueResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :create_queue)
    assert response[:queue_url] == "http://queue.amazonaws.com/123456789012/testQueue"
    assert response[:request_id] == "7a62c49f-347e-4fc4-9331-6e8e7a96aa73"
  end

  test "parsing a change message visibility response" do
    rsp = """
    <ChangeMessageVisibilityResponse>
      <ResponseMetadata>
        <RequestId>6a7a282a-d013-4a59-aba9-335b0fa48bed</RequestId>
      </ResponseMetadata>
    </ChangeMessageVisibilityResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :change_message_visibility)
    assert response[:request_id] == "6a7a282a-d013-4a59-aba9-335b0fa48bed"
  end


  test "parsing a change message visibilty batch response" do
    rsp = """
    <ChangeMessageVisibilityBatchResponse>
      <ChangeMessageVisibilityBatchResult>
        <ChangeMessageVisibilityBatchResultEntry>
          <Id>change_visibility_msg_2</Id>
        </ChangeMessageVisibilityBatchResultEntry>
        <ChangeMessageVisibilityBatchResultEntry>
          <Id>change_visibility_msg_3</Id>
        </ChangeMessageVisibilityBatchResultEntry>
        </ChangeMessageVisibilityBatchResult>
    <ResponseMetadata>
      <RequestId>ca9668f7-ab1b-4f7a-8859-f15747ab17a7</RequestId>
    </ResponseMetadata>
    </ChangeMessageVisibilityBatchResponse>
    """
    |> to_success
    {:ok, %{body: response}} = Parsers.parse(rsp, :change_message_visibility_batch)

    assert ["change_visibility_msg_2", "change_visibility_msg_3"] == response[:successes]
    assert "ca9668f7-ab1b-4f7a-8859-f15747ab17a7" == response[:request_id]
  end

  test "parsing a delete message response" do
    rsp = """
    <DeleteMessageResponse>
      <ResponseMetadata>
        <RequestId>b5293cb5-d306-4a17-9048-b263635abe42</RequestId>
      </ResponseMetadata>
    </DeleteMessageResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :delete_message)
    assert "b5293cb5-d306-4a17-9048-b263635abe42" == response[:request_id]
  end

  test "parsing a delete message batch response" do
    rsp = """
    <DeleteMessageBatchResponse>
      <DeleteMessageBatchResult>
        <DeleteMessageBatchResultEntry>
          <Id>msg1</Id>
        </DeleteMessageBatchResultEntry>
        <DeleteMessageBatchResultEntry>
          <Id>msg2</Id>
        </DeleteMessageBatchResultEntry>
      </DeleteMessageBatchResult>
      <ResponseMetadata>
        <RequestId>d6f86b7a-74d1-4439-b43f-196a1e29cd85</RequestId>
      </ResponseMetadata>
    </DeleteMessageBatchResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :delete_message_batch)
    assert ["msg1", "msg2"] == response[:successes]
    assert "d6f86b7a-74d1-4439-b43f-196a1e29cd85" == response[:request_id]
  end

  test "parsing a delete queue response" do
    rsp = """
    <DeleteQueueResponse>
      <ResponseMetadata>
        <RequestId>6fde8d1e-52cd-4581-8cd9-c512f4c64223</RequestId>
      </ResponseMetadata>
    </DeleteQueueResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :delete_queue)
    assert "6fde8d1e-52cd-4581-8cd9-c512f4c64223" == response[:request_id]
  end

  test "parsing a get queue attributes response" do
    rsp = """
      <GetQueueAttributesResponse>
        <GetQueueAttributesResult>
          <Attribute>
            <Name>ReceiveMessageWaitTimeSeconds</Name>
            <Value>2</Value>
          </Attribute>
          <Attribute>
            <Name>VisibilityTimeout</Name>
            <Value>30</Value>
          </Attribute>
          <Attribute>
            <Name>ApproximateNumberOfMessages</Name>
            <Value>0</Value>
          </Attribute>
          <Attribute>
            <Name>ApproximateNumberOfMessagesNotVisible</Name>
            <Value>0</Value>
          </Attribute>
          <Attribute>
            <Name>CreatedTimestamp</Name>
            <Value>1286771522</Value>
          </Attribute>
          <Attribute>
            <Name>LastModifiedTimestamp</Name>
            <Value>1286771522</Value>
          </Attribute>
          <Attribute>
            <Name>QueueArn</Name>
            <Value>arn:aws:sqs:us-east-1:123456789012:qfoo</Value>
          </Attribute>
          <Attribute>
            <Name>MaximumMessageSize</Name>
            <Value>8192</Value>
          </Attribute>
          <Attribute>
            <Name>MessageRetentionPeriod</Name>
            <Value>345600</Value>
          </Attribute>
          <Attribute>
            <Name>FifoQueue</Name>
            <Value>true</Value>
          </Attribute>
          <Attribute>
            <Name>ContentBasedDeduplication</Name>
            <Value>false</Value>
          </Attribute>
        </GetQueueAttributesResult>
        <ResponseMetadata>
          <RequestId>1ea71be5-b5a2-4f9d-b85a-945d8d08cd0b</RequestId>
        </ResponseMetadata>
    </GetQueueAttributesResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :get_queue_attributes)
    attributes = response[:attributes]
    assert 2 == attributes[:receive_message_wait_time_seconds]
    assert "arn:aws:sqs:us-east-1:123456789012:qfoo" == attributes[:queue_arn]
    assert 30 == attributes[:visibility_timeout]
    assert true == attributes[:fifo_queue]
    assert false == attributes[:content_based_deduplication]
    assert "1ea71be5-b5a2-4f9d-b85a-945d8d08cd0b" == response[:request_id]
  end

  test "parsing a get queue url response" do
    rsp = """
    <GetQueueUrlResponse>
      <GetQueueUrlResult>
        <QueueUrl>http://sqs.us-east-1.amazonaws.com/123456789012/testQueue</QueueUrl>
      </GetQueueUrlResult>
      <ResponseMetadata>
        <RequestId>470a6f13-2ed9-4181-ad8a-2fdea142988e</RequestId>
      </ResponseMetadata>
    </GetQueueUrlResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :get_queue_url)

    assert "http://sqs.us-east-1.amazonaws.com/123456789012/testQueue" == response[:queue_url]
    assert "470a6f13-2ed9-4181-ad8a-2fdea142988e" == response[:request_id]
  end

  test "parse list dead letter source queues response" do
    rsp = """
    <ListDeadLetterSourceQueuesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
      <ListDeadLetterSourceQueuesResult>
        <QueueUrl>http://sqs.us-east-1.amazonaws.com/123456789012/MySourceQueue</QueueUrl>
        <QueueUrl>http://sqs.us-east-1.amazonaws.com/123456772800/MyOtherSourceQueue</QueueUrl>
    </ListDeadLetterSourceQueuesResult>
    <ResponseMetadata>
      <RequestId>8ffb921f-b85e-53d9-abcf-d8d0057f38fc</RequestId>
    </ResponseMetadata>
    </ListDeadLetterSourceQueuesResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :list_dead_letter_source_queues)

    assert ["http://sqs.us-east-1.amazonaws.com/123456789012/MySourceQueue",
            "http://sqs.us-east-1.amazonaws.com/123456772800/MyOtherSourceQueue"
           ] == response[:queue_urls]
    assert "8ffb921f-b85e-53d9-abcf-d8d0057f38fc" == response[:request_id]
  end

  test "parsing a purge queue response" do
    rsp = """
    <PurgeQueueResponse>
      <ResponseMetadata>
        <RequestId>6fde8d1e-52cd-4581-8cd9-c512f4c64223</RequestId>
      </ResponseMetadata>
    </PurgeQueueResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :purge_queue)
    assert "6fde8d1e-52cd-4581-8cd9-c512f4c64223" == response[:request_id]
  end

  test "parsing a receive message response" do
    rsp = """
    <ReceiveMessageResponse>
      <ReceiveMessageResult>
        <Message>
          <MessageId>5fea7756-0ea4-451a-a703-a558b933e274</MessageId>
          <ReceiptHandle>MbZj6wDWli+JvwwJaBV+3dcjk2YW2vA3+STFFljTM8tJJg6HRG6PYSasuWXPJB+CwLj1FjgXUv1uSj1gUPAWV66FU/WeR4mq2OKpEGYWbnLmpRCJVAyeMjeU5ZBdtcQ+QEauMZc8ZRv37sIW2iJKq3M9MFx1YvV11A2x/KSbkJ0=</ReceiptHandle>
          <MD5OfBody>fafb00f5732ab283681e124bf8747ed1</MD5OfBody>
          <Body>This is a test message</Body>
          <Attribute>
            <Name>SenderId</Name>
            <Value>195004372649</Value>
          </Attribute>
          <Attribute>
            <Name>SentTimestamp</Name>
            <Value>1238099229000</Value>
          </Attribute>
          <Attribute>
            <Name>ApproximateReceiveCount</Name>
            <Value>5</Value>
          </Attribute>
          <Attribute>
            <Name>ApproximateFirstReceiveTimestamp</Name>
            <Value>1250700979248</Value>
          </Attribute>
        </Message>
      </ReceiveMessageResult>
      <ResponseMetadata>
        <RequestId>b6633655-283d-45b4-aee4-4e84e0ae6afa</RequestId>
      </ResponseMetadata>
    </ReceiveMessageResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :receive_message)
    [message] = response[:messages]

    handle = "MbZj6wDWli+JvwwJaBV+3dcjk2YW2vA3+STFFljTM8tJJg6HRG6PYSasuWXPJB+CwLj1FjgXUv1uSj1gUPAWV66FU/WeR4mq2OKpEGYWbnLmpRCJVAyeMjeU5ZBdtcQ+QEauMZc8ZRv37sIW2iJKq3M9MFx1YvV11A2x/KSbkJ0="

    assert "b6633655-283d-45b4-aee4-4e84e0ae6afa" == response[:request_id]
    assert "This is a test message" == message[:body]
    assert handle == message[:receipt_handle]
    assert "fafb00f5732ab283681e124bf8747ed1" == message[:md5_of_body]

    attributes = message[:attributes]

    assert 195004372649 == attributes["sender_id"]
    assert 1238099229000 == attributes["sent_timestamp"]
    assert 5 == attributes["approximate_receive_count"]
    assert 1250700979248 == attributes["approximate_first_receive_timestamp"]
  end

  test "parsing a receive message response with multiple messages" do
    rsp = """
    <?xml version=\"1.0\"?>
    <ReceiveMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">
      <ReceiveMessageResult>
        <Message>
          <MessageId>70723100-7a9e-474c-9342-4a07b5d3bcff</MessageId>
          <ReceiptHandle>AQEB1vSE6FNrf7oYptJYdkVMvdx1bO6ysaovI++YzylE2GoFH9kXAfnThwfy8wXGjl0XXEx3v7jh3bv353AL3+ODUYSY5vDAr2Xi1JqS96gU/MppM1et/dPYBYQcMUC9a/0GMojJ4AKAfxqYnov9VLzzi5zAgQIxnHp/hB3s30ZP7NaIsOe4d3rXWDwavmqwR/pfl+3krPUhiGwlTaETQkmkmE2KN/iD0X/NPNhxeFho7EHR9tCHK9mzbsdbwbRpRI4ZYfVDzzTx6kjZO9qeEKetL8XZ1InXEhQwqqv96Vvm3gIZJM+2if46WcZQexVT7GiMjIxNkXJjoCaGfAojxf1KAnIseZQZGTJpbt5NqfXPBJBThCJ4ocCt8lRm7qS25fVLHgr1dnQGE032uLpzXc04ti2MXTdBYkJlq285pyCi1wI=</ReceiptHandle>
          <MD5OfBody>68ee3fbec6195f397d7f696599dd278a</MD5OfBody>
          <Body>Message 1</Body>
          <MessageAttribute>
            <Name>SequenceId</Name>
              <Value>
                <StringValue>first</StringValue>
                <DataType>String</DataType>
              </Value>
            </MessageAttribute>
          </Message>
          <Message>
            <MessageId>685b3199-2350-476e-a9b4-b9357597c5f9</MessageId>
            <ReceiptHandle>AQEBnaNIuXS7t7/+QgcF8e7aD83Is8Q3+jPTLK6Rb7qkZYs50EhaR4JAjNeMrWT4viwwoK4ziWNMGZaZfmIHUS667Pua3yOFC2nKRi5ZnOPxGFfRo/ilVb8kuPQmcoDLFAGwQA5hjVlKwNd3YvfXtYZsJwiMEEbbKqwYhJD1bTxMbMesorO8WtU7kqrlTghS3P7Ze6YD3ESivzVDsghA+wRavj17HGtRSudc5kkCgPhorLQNeVBLtticW2BpqF2+wclv8fB+JtCU6s0nSE/LbqQppj8xrX1MzqdMIcYpTrQ4CGdjZ9JZwv+3yG3H5l31w9zwxced7VuJQ3854I0dHk43Jq1+iaCBKTynRumYgWAViSafeR/V3wIzIfpFsnHVmo5GWtOJVgNWHQLBJ0LocHQZ2vj4JH/hewhhyzdt3jKQ1eA=</ReceiptHandle>
            <MD5OfBody>47f79c924409f444efd458d9976becb5</MD5OfBody>
            <Body>Message 2</Body>
            <MessageAttribute>
              <Name>SequenceId</Name>
              <Value>
                <StringValue>second</StringValue>
                <DataType>String</DataType>
              </Value>
            </MessageAttribute>
          </Message>
        </ReceiveMessageResult>
      <ResponseMetadata>
        <RequestId>e74a318e-f911-56da-8302-61e0baee07ae</RequestId>
      </ResponseMetadata>
    </ReceiveMessageResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :receive_message)
    [message_1, message_2] = response[:messages]

    assert "Message 1" == message_1.body
    assert %{value: "first"}  = message_1.message_attributes["SequenceId"]

    assert "Message 2" == message_2.body
    assert %{value: "second"}  = message_2.message_attributes["SequenceId"]
  end

  test "parsing an empty receive message response" do
    rsp = """
    <?xml version=\"1.0\"?>
    <ReceiveMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">
      <ReceiveMessageResult/>
      <ResponseMetadata>
        <RequestId>fcd6512a-5746-5803-b2d7-014dfd07f23a</RequestId>
      </ResponseMetadata>
    </ReceiveMessageResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :receive_message)

    assert "fcd6512a-5746-5803-b2d7-014dfd07f23a" == response[:request_id]
    assert [] == response[:messages]
  end

  test "it should handle parsing a message with custom attributes" do
    rsp = """
    <?xml version=\"1.0\"?>
      <ReceiveMessageResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">
        <ReceiveMessageResult>
          <Message>
            <MessageId>c13a41a6-be30-4940-a3fb-a673157aaae6</MessageId>
            <ReceiptHandle>AQEB1HCawlmYXAwe44T7qon7+Q37+S/1SciTg9Qv9/NeoB/or+oxh4aKHlJItnYwyk2xh5uspMdmxZ//xkpYNeMeqyIajl/BETTCUL1IJLprWVN6+5KQKmFU9QJxaVplYpT5dsfc2at5EiY5d25i/x6A52tnyj/OiaLw35WI8gEfaJtrMJJskAoNTbq5X6PrSkLOMzYcpD//9vSp3gnmdQaBm8aQgfeT5/1SASGG1w6jpXlfBSCwpj3hRrhx2qqpP9u2u0711S3/XygJtyWS1iQEMcaSps0KjG5kiQFXAel1geNxrCixNcupLbF54Sam63IUe7NgOZED++y7Qv+d/kNFhuzgF2PjRUbVgjQQBAcLZm3jpd+slKGMNyi4OfePbao5PeS6yIvqUaApCAD3N7t+0+2IjMrosr0B80su4gVpJqc=</ReceiptHandle>
            <MD5OfBody>c2d900c011c138c4a68934fee2fdd344</MD5OfBody>
            <MD5OfMessageAttributes>01b71960a46e9ef0bd66bfc5a817e156</MD5OfMessageAttributes>
            <Body>with attributes</Body>
            <Attribute><Name>SenderId</Name><Value>IAmTheSender</Value></Attribute>
            <Attribute><Name>ApproximateFirstReceiveTimestamp</Name><Value>1475601158305</Value></Attribute>
            <Attribute><Name>ApproximateReceiveCount</Name><Value>1</Value></Attribute>
            <Attribute><Name>SentTimestamp</Name><Value>1475601143281</Value></Attribute>
            <MessageAttribute>
              <Name>BinaryVal</Name>
              <Value>
                <BinaryValue>AwYJDA==</BinaryValue>
                <DataType>Binary</DataType>
              </Value>
            </MessageAttribute>
            <MessageAttribute>
              <Name>GifVal</Name>
              <Value>
                <BinaryValue>AgQGCAoM</BinaryValue>
                <DataType>Binary.gif</DataType>
              </Value>
            </MessageAttribute>
            <MessageAttribute>
              <Name>LiveAt</Name>
              <Value>
                <StringValue>good</StringValue>
                <DataType>String</DataType>
              </Value>
            </MessageAttribute>
            <MessageAttribute>
              <Name>UrlVal</Name>
              <Value>
                <StringValue>http://elixir-lang.org</StringValue>
                <DataType>String.URL</DataType>
              </Value>
            </MessageAttribute>
            <MessageAttribute>
              <Name>NumberVal</Name>
              <Value>
                <StringValue>382</StringValue>
                <DataType>Number</DataType>
              </Value>
            </MessageAttribute>
            <MessageAttribute>
              <Name>FloatVal</Name>
              <Value>
                <StringValue>382.03</StringValue>
                <DataType>Number.float</DataType>
              </Value>
            </MessageAttribute>
            <MessageAttribute>
              <Name>UnknownVal</Name>
              <Value>
                <StringValue>blarg</StringValue>
                <DataType>Unknown</DataType>
              </Value>
            </MessageAttribute>
          </Message>
        </ReceiveMessageResult>
      <ResponseMetadata>
        <RequestId>15d62100-b15d-57d4-bd4b-716d541b2dee</RequestId>
      </ResponseMetadata>
    </ReceiveMessageResponse>
    """
    |> to_success
    {:ok, %{body: response}} = Parsers.parse(rsp, :receive_message)
    [message] = response[:messages]
    message_attributes = message[:message_attributes]

    assert %{value: "good", data_type: "String"} = message_attributes["LiveAt"]
    assert %{value: 382, data_type: "Number"} = message_attributes["NumberVal"]
    assert %{value: <<3, 6, 9, 12>>, data_type: "Binary"} = message_attributes["BinaryVal"]
    assert %{value: 382.03, data_type: "Number.float"} = message_attributes["FloatVal"]
    assert %{value: <<2, 4, 6, 8, 10, 12>>, data_type: "Binary.gif"} = message_attributes["GifVal"]
    assert %{value: "http://elixir-lang.org", data_type: "String.URL"} = message_attributes["UrlVal"]
    assert %{string_value: "blarg", binary_value: "", data_type: "Unknown", name: "UnknownVal"} == message_attributes["UnknownVal"]
  end

  test "handling a remove permission response" do
    rsp = """
    <RemovePermissionResponse>
      <ResponseMetadata>
        <RequestId>f8bdb362-6616-42c0-977a-ce9a8bcce3bb</RequestId>
      </ResponseMetadata>
    </RemovePermissionResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :remove_permission)
    assert "f8bdb362-6616-42c0-977a-ce9a8bcce3bb" == response[:request_id]
  end

  test "handling a send message response" do
    rsp = """
    <SendMessageResponse>
      <SendMessageResult>
        <MD5OfMessageBody>fafb00f5732ab283681e124bf8747ed1</MD5OfMessageBody>
        <MD5OfMessageAttributes>3ae8f24a165a8cedc005670c81a27295</MD5OfMessageAttributes>
        <MessageId>5fea7756-0ea4-451a-a703-a558b933e274</MessageId>
      </SendMessageResult>
      <ResponseMetadata>
        <RequestId>27daac76-34dd-47df-bd01-1f6e873584a0</RequestId>
      </ResponseMetadata>
    </SendMessageResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :send_message)

    assert "27daac76-34dd-47df-bd01-1f6e873584a0" == response[:request_id]
    assert "fafb00f5732ab283681e124bf8747ed1" == response[:md5_of_message_body]
    assert "3ae8f24a165a8cedc005670c81a27295" == response[:md5_of_message_attributes]
    assert "5fea7756-0ea4-451a-a703-a558b933e274" == response[:message_id]
  end

  test "handling a send message batch response" do
    rsp = """
    <SendMessageBatchResponse>
      <SendMessageBatchResult>
        <SendMessageBatchResultEntry>
          <Id>test_msg_001</Id>
          <MessageId>0a5231c7-8bff-4955-be2e-8dc7c50a25fa</MessageId>
          <MD5OfMessageBody>0e024d309850c78cba5eabbeff7cae71</MD5OfMessageBody>
        </SendMessageBatchResultEntry>
        <SendMessageBatchResultEntry>
          <Id>test_msg_002</Id>
          <MessageId>15ee1ed3-87e7-40c1-bdaa-2e49968ea7e9</MessageId>
          <MD5OfMessageBody>7fb8146a82f95e0af155278f406862c2</MD5OfMessageBody>
          <MD5OfMessageAttributes>295c5fa15a51aae6884d1d7c1d99ca50</MD5OfMessageAttributes>
        </SendMessageBatchResultEntry>
      </SendMessageBatchResult>
      <ResponseMetadata>
        <RequestId>ca1ad5d0-8271-408b-8d0f-1351bf547e74</RequestId>
      </ResponseMetadata>
    </SendMessageBatchResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :send_message_batch)

    assert "ca1ad5d0-8271-408b-8d0f-1351bf547e74" == response[:request_id]
    assert [first, second] = response[:successes]

    assert "test_msg_001" == first[:id]
    assert "0a5231c7-8bff-4955-be2e-8dc7c50a25fa" == first[:message_id]
    assert "0e024d309850c78cba5eabbeff7cae71" == first[:md5_of_message_body]
    refute :md5_of_message_attributes in first

    assert "test_msg_002" == second[:id]
    assert "15ee1ed3-87e7-40c1-bdaa-2e49968ea7e9" == second[:message_id]
    assert "7fb8146a82f95e0af155278f406862c2" == second[:md5_of_message_body]
    assert "295c5fa15a51aae6884d1d7c1d99ca50" == second[:md5_of_message_attributes]
  end

  test "it should handle a set queue attributes response" do
    rsp = """
    <SetQueueAttributesResponse>
      <ResponseMetadata>
        <RequestId>e5cca473-4fc0-4198-a451-8abb94d02c75</RequestId>
      </ResponseMetadata>
    </SetQueueAttributesResponse>
    """
    |> to_success

    {:ok, %{body: response}} = Parsers.parse(rsp, :set_queue_attributes)

    assert "e5cca473-4fc0-4198-a451-8abb94d02c75" == response[:request_id]
  end
end
