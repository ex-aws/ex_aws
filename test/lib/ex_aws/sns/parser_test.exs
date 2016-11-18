defmodule ExAws.SNS.ParserTest do
  use ExUnit.Case, async: true

  alias ExAws.SNS.Parsers

  def to_success(doc) do
    {:ok, %{body: doc}}
  end

  def to_error(doc) do
    {:error, {:http_error, 403, %{body: doc}}}
  end

  test "#parsing a list_topics response" do
    rsp = """
      <ListTopicsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ListTopicsResult>
          <Topics>
            <member>
              <TopicArn>arn:aws:sns:us-east-1:123456789012:My-Topic</TopicArn>
            </member>
          </Topics>
        </ListTopicsResult>
        <ResponseMetadata>
          <RequestId>3f1478c7-33a9-11df-9540-99d0768312d3</RequestId>
        </ResponseMetadata>
      </ListTopicsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_topics)
    assert parsed_doc[:topics] == ["arn:aws:sns:us-east-1:123456789012:My-Topic"]
    assert parsed_doc[:request_id] == "3f1478c7-33a9-11df-9540-99d0768312d3"
  end

  test "#parsing a create_topic response" do
    rsp = """
      <CreateTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <CreateTopicResult>
          <TopicArn>arn:aws:sns:us-east-1:123456789012:My-Topic</TopicArn>
        </CreateTopicResult>
        <ResponseMetadata>
          <RequestId>a8dec8b3-33a4-11df-8963-01868b7c937a</RequestId>
        </ResponseMetadata>
      </CreateTopicResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :create_topic)
    assert parsed_doc[:topic_arn] == "arn:aws:sns:us-east-1:123456789012:My-Topic"
    assert parsed_doc[:request_id] == "a8dec8b3-33a4-11df-8963-01868b7c937a"
  end

  test "#parsing a get_topic_attributes response" do
    rsp = """
      <GetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <GetTopicAttributesResult>
          <Attributes>
            <entry>
              <key>Owner</key>
              <value>123456789012</value>
            </entry>
            <entry>
              <key>Policy</key>
              <value>some_json</value>
            </entry>
            <entry>
              <key>TopicArn</key>
              <value>arn:aws:sns:us-east-1:123456789012:My-Topic</value>
            </entry>
            <entry>
              <key>SubscriptionsPending</key>
              <value>12</value>
            </entry>
            <entry>
              <key>SubscriptionsConfirmed</key>
              <value>4</value>
            </entry>
            <entry>
              <key>SubscriptionsDeleted</key>
              <value>9</value>
            </entry>
          </Attributes>
        </GetTopicAttributesResult>
        <ResponseMetadata>
          <RequestId>057f074c-33a7-11df-9540-99d0768312d3</RequestId>
        </ResponseMetadata>
      </GetTopicAttributesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :get_topic_attributes)
    assert parsed_doc[:owner] == "123456789012"
    assert parsed_doc[:policy] == "some_json"
    assert parsed_doc[:topic_arn] == "arn:aws:sns:us-east-1:123456789012:My-Topic"
    assert parsed_doc[:subscriptions_pending] == 12
    assert parsed_doc[:subscriptions_confirmed] == 4
    assert parsed_doc[:subscriptions_deleted] == 9
    assert parsed_doc[:request_id] == "057f074c-33a7-11df-9540-99d0768312d3"
  end

  test "#parsing a set_topic_attributes response" do
    rsp = """
      <SetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>a8763b99-33a7-11df-a9b7-05d48da6f042</RequestId>
        </ResponseMetadata>
      </SetTopicAttributesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :set_topic_attributes)
    assert parsed_doc[:request_id] == "a8763b99-33a7-11df-a9b7-05d48da6f042"
  end

  test "#parsing a delete_topic response" do
    rsp = """
      <DeleteTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>f3aa9ac9-3c3d-11df-8235-9dab105e9c32</RequestId>
        </ResponseMetadata>
      </DeleteTopicResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :delete_topic)
    assert parsed_doc[:request_id] == "f3aa9ac9-3c3d-11df-8235-9dab105e9c32"
  end

  test "#parsing a publish response" do
    rsp = """
      <PublishResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <PublishResult>
          <MessageId>94f20ce6-13c5-43a0-9a9e-ca52d816e90b</MessageId>
        </PublishResult>
        <ResponseMetadata>
          <RequestId>f187a3c1-376f-11df-8963-01868b7c937a</RequestId>
        </ResponseMetadata>
      </PublishResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :publish)
    assert parsed_doc[:message_id] == "94f20ce6-13c5-43a0-9a9e-ca52d816e90b"
    assert parsed_doc[:request_id] == "f187a3c1-376f-11df-8963-01868b7c937a"
  end

  test "#parsing a create_platform_application response" do
    rsp = """
      <CreatePlatformApplicationResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <CreatePlatformApplicationResult>
          <PlatformApplicationArn>arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp</PlatformApplicationArn>
        </CreatePlatformApplicationResult>
        <ResponseMetadata>
          <RequestId>b6f0e78b-e9d4-5a0e-b973-adc04e8a4ff9</RequestId>
        </ResponseMetadata>
      </CreatePlatformApplicationResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :create_platform_application)
    assert parsed_doc[:platform_application_arn] == "arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp"
    assert parsed_doc[:request_id] == "b6f0e78b-e9d4-5a0e-b973-adc04e8a4ff9"
  end

  test "#parsing a delete_platform_application response" do
    rsp = """
      <DeletePlatformApplicationResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>097dac18-7a77-5823-a8dd-e65476dcb037</RequestId>
        </ResponseMetadata>
      </DeletePlatformApplicationResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :delete_platform_application)
    assert parsed_doc[:request_id] == "097dac18-7a77-5823-a8dd-e65476dcb037"
  end

  test "#parsing a create_platform_endpoint response" do
    rsp = """
      <CreatePlatformEndpointResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <CreatePlatformEndpointResult>
          <EndpointArn>arn:aws:sns:us-west-2:123456789012:endpoint/GCM/gcmpushapp/5e3e9847-3183-3f18-a7e8-671c3a57d4b3</EndpointArn>
        </CreatePlatformEndpointResult>
        <ResponseMetadata>
          <RequestId>6613341d-3e15-53f7-bf3c-7e56994ba278</RequestId>
        </ResponseMetadata>
      </CreatePlatformEndpointResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :create_platform_endpoint)
    assert parsed_doc[:endpoint_arn] == "arn:aws:sns:us-west-2:123456789012:endpoint/GCM/gcmpushapp/5e3e9847-3183-3f18-a7e8-671c3a57d4b3"
    assert parsed_doc[:request_id] == "6613341d-3e15-53f7-bf3c-7e56994ba278"
  end

  test "#parsing a list_platform_applications response" do
    rsp = """
      <ListPlatformApplicationsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ListPlatformApplicationsResult>
          <PlatformApplications>
            <member>
              <PlatformApplicationArn>arn:aws:sns:us-west-2:123456789012:app/APNS_SANDBOX/apnspushapp</PlatformApplicationArn>
               <Attributes>
                <entry>
                  <key>AllowEndpointPolicies</key>
                  <value>false</value>
                </entry>
              </Attributes>
            </member>
            <member>
              <PlatformApplicationArn>arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp</PlatformApplicationArn>
              <Attributes>
                <entry>
                  <key>AllowEndpointPolicies</key>
                  <value>true</value>
                </entry>
              </Attributes>
            </member>
          </PlatformApplications>
        </ListPlatformApplicationsResult>
        <ResponseMetadata>
          <RequestId>315a335e-85d8-52df-9349-791283cbb529</RequestId>
        </ResponseMetadata>
      </ListPlatformApplicationsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_platform_applications)
    assert parsed_doc[:applications] == [
     %{
       platform_application_arn: "arn:aws:sns:us-west-2:123456789012:app/APNS_SANDBOX/apnspushapp",
       attributes: [%{key: "AllowEndpointPolicies", value: "false"}]
     },
     %{
       platform_application_arn: "arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp",
       attributes: [%{key: "AllowEndpointPolicies", value: "true"}]
     }
    ]
    assert parsed_doc[:next_token] == ""
    assert parsed_doc[:request_id] == "315a335e-85d8-52df-9349-791283cbb529"
  end

  test "#parsing a list_platform_applications response with next_token" do
    rsp = """
      <ListPlatformApplicationsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ListPlatformApplicationsResult>
          <PlatformApplications>
            <member>
              <PlatformApplicationArn>arn:aws:sns:us-west-2:123456789012:app/APNS_SANDBOX/apnspushapp</PlatformApplicationArn>
               <Attributes>
                <entry>
                  <key>AllowEndpointPolicies</key>
                  <value>false</value>
                </entry>
              </Attributes>
            </member>
            <member>
              <PlatformApplicationArn>arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp</PlatformApplicationArn>
              <Attributes>
                <entry>
                  <key>AllowEndpointPolicies</key>
                  <value>true</value>
                </entry>
              </Attributes>
            </member>
          </PlatformApplications>
          <NextToken>123456789</NextToken>
        </ListPlatformApplicationsResult>
        <ResponseMetadata>
          <RequestId>315a335e-85d8-52df-9349-791283cbb529</RequestId>
        </ResponseMetadata>
      </ListPlatformApplicationsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_platform_applications)
    assert parsed_doc[:applications] == [
     %{
       platform_application_arn: "arn:aws:sns:us-west-2:123456789012:app/APNS_SANDBOX/apnspushapp",
       attributes: [%{key: "AllowEndpointPolicies", value: "false"}]
     },
     %{
       platform_application_arn: "arn:aws:sns:us-west-2:123456789012:app/GCM/gcmpushapp",
       attributes: [%{key: "AllowEndpointPolicies", value: "true"}]
     }
    ]
    assert parsed_doc[:next_token] == "123456789"
    assert parsed_doc[:request_id] == "315a335e-85d8-52df-9349-791283cbb529"
  end

  test "#parsing a get_platform_application_attributes response" do
    created_arn = "arn:aws:sns:us-east-1:123456789012:Event-Created"
    updated_arn = "arn:aws:sns:us-east-1:123456789012:Event-Updated"
    deleted_arn = "arn:aws:sns:us-east-1:123456789012:Event-Deleted"
    failure_arn = "arn:aws:sns:us-east-1:123456789012:Delivery-Failure"
    rsp = """
      <GetPlatformApplicationAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <GetPlatformApplicationAttributesResult>
          <Attributes>
            <entry>
              <key>EventEndpointCreated</key>
              <value>#{created_arn}</value>
            </entry>
            <entry>
              <key>EventEndpointUpdated</key>
              <value>#{updated_arn}</value>
            </entry>
            <entry>
              <key>EventEndpointDeleted</key>
              <value>#{deleted_arn}</value>
            </entry>
            <entry>
              <key>EventDeliveryFailure</key>
              <value>#{failure_arn}</value>
            </entry>
          </Attributes>
        </GetPlatformApplicationAttributesResult>
        <ResponseMetadata>
          <RequestId>74848df2-87f6-55ed-890c-c7be80442462</RequestId>
        </ResponseMetadata>
      </GetPlatformApplicationAttributesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :get_platform_application_attributes)
    assert parsed_doc[:event_endpoint_created] == created_arn
    assert parsed_doc[:event_endpoint_updated] == updated_arn
    assert parsed_doc[:event_endpoint_deleted] == deleted_arn
    assert parsed_doc[:event_delivery_failure] == failure_arn
  end

  test "#parsing a subscribe response" do
    rsp = """
      <SubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <SubscribeResult>
          <SubscriptionArn>arn:aws:sns:us-west-2:123456789012:MyTopic:6b0e71bd-7e97-4d97-80ce-4a0994e55286</SubscriptionArn>
        </SubscribeResult>
        <ResponseMetadata>
          <RequestId>c4407779-24a4-56fa-982c-3d927f93a775</RequestId>
        </ResponseMetadata>
      </SubscribeResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :subscribe)
    assert parsed_doc[:subscription_arn] == "arn:aws:sns:us-west-2:123456789012:MyTopic:6b0e71bd-7e97-4d97-80ce-4a0994e55286"
    assert parsed_doc[:request_id] == "c4407779-24a4-56fa-982c-3d927f93a775"
  end

  test "#parsing a confirm subscription response" do
    rsp = """
      <ConfirmSubscriptionResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ConfirmSubscriptionResult>
          <SubscriptionArn>arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca</SubscriptionArn>
        </ConfirmSubscriptionResult>
        <ResponseMetadata>
          <RequestId>7a50221f-3774-11df-a9b7-05d48da6f042</RequestId>
        </ResponseMetadata>
      </ConfirmSubscriptionResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :confirm_subscription)
    assert parsed_doc[:subscription_arn] == "arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca"
    assert parsed_doc[:request_id] == "7a50221f-3774-11df-a9b7-05d48da6f042"
  end

  test "#parsing a list_subscriptions response" do
    rsp = """
      <ListSubscriptionsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ListSubscriptionsResult>
          <Subscriptions>
            <member>
              <TopicArn>arn:aws:sns:us-east-1:698519295917:My-Topic</TopicArn>
              <Protocol>email</Protocol>
              <SubscriptionArn>arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca</SubscriptionArn>
              <Owner>123456789012</Owner>
              <Endpoint>example@amazon.com</Endpoint>
            </member>
          </Subscriptions>
        </ListSubscriptionsResult>
        <ResponseMetadata>
          <RequestId>384ac68d-3775-11df-8963-01868b7c937a</RequestId>
        </ResponseMetadata>
      </ListSubscriptionsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_subscriptions)
    assert parsed_doc[:subscriptions] == [
      %{
        owner: "123456789012",
        endpoint: "example@amazon.com",
        protocol: "email",
        subscription_arn: "arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca",
        topic_arn: "arn:aws:sns:us-east-1:698519295917:My-Topic"
      }
    ]
    assert parsed_doc[:next_token] == ""
    assert parsed_doc[:request_id] == "384ac68d-3775-11df-8963-01868b7c937a"
  end

  test "#parsing a list_subscriptions response with a next token" do
    rsp = """
      <ListSubscriptionsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ListSubscriptionsResult>
          <Subscriptions>
            <member>
              <TopicArn>arn:aws:sns:us-east-1:698519295917:My-Topic</TopicArn>
              <Protocol>email</Protocol>
              <SubscriptionArn>arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca</SubscriptionArn>
              <Owner>123456789012</Owner>
              <Endpoint>example@amazon.com</Endpoint>
            </member>
          </Subscriptions>
          <NextToken>123456789</NextToken>
        </ListSubscriptionsResult>
        <ResponseMetadata>
          <RequestId>384ac68d-3775-11df-8963-01868b7c937a</RequestId>
        </ResponseMetadata>
      </ListSubscriptionsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_subscriptions)
    assert parsed_doc[:subscriptions] == [
      %{
        owner: "123456789012",
        endpoint: "example@amazon.com",
        protocol: "email",
        subscription_arn: "arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca",
        topic_arn: "arn:aws:sns:us-east-1:698519295917:My-Topic"
      }
    ]
    assert parsed_doc[:next_token] == "123456789"
    assert parsed_doc[:request_id] == "384ac68d-3775-11df-8963-01868b7c937a"
  end

  test "#parsing an unsubscribe response" do
    rsp = """
      <UnsubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>18e0ac39-3776-11df-84c0-b93cc1666b84</RequestId>
        </ResponseMetadata>
      </UnsubscribeResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :unsubscribe)
    assert parsed_doc[:request_id] == "18e0ac39-3776-11df-84c0-b93cc1666b84"
  end

  test "#parsing a get_subscription_attributes response" do
    rsp = """
      <GetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <GetSubscriptionAttributesResult>
          <Attributes>
            <entry>
              <key>Owner</key>
              <value>123456789012</value>
            </entry>
            <entry>
              <key>DeliveryPolicy</key>
              <value>{&quot;healthyRetryPolicy&quot;:{&quot;numRetries&quot;:10}}</value>
            </entry>
            <entry>
              <key>EffectiveDeliveryPolicy</key>
              <value>{&quot;healthyRetryPolicy&quot;:{&quot;numRetries&quot;:10}}</value>
            </entry>
            <entry>
              <key>SubscriptionArn</key>
              <value>arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca</value>
            </entry>
            <entry>
              <key>ConfirmationWasAuthenticated</key>
              <value>true</value>
            </entry>
          </Attributes>
        </GetSubscriptionAttributesResult>
        <ResponseMetadata>
          <RequestId>057f074c-33a7-11df-9540-99d0768312d3</RequestId>
        </ResponseMetadata>
      </GetSubscriptionAttributesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :get_subscription_attributes)
    assert parsed_doc[:owner] == "123456789012"
    assert parsed_doc[:delivery_policy] == ~s({"healthyRetryPolicy":{"numRetries":10}})
    assert parsed_doc[:effective_delivery_policy] == ~s({"healthyRetryPolicy":{"numRetries":10}})
    assert parsed_doc[:subscription_arn] == "arn:aws:sns:us-east-1:123456789012:My-Topic:80289ba6-0fd4-4079-afb4-ce8c8260f0ca"
    assert parsed_doc[:confirmation_was_authenticated] == true
  end

  test "#parsing a set_subscription_attributes response" do
    rsp = """
      <SetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>a8763b99-33a7-11df-a9b7-05d48da6f042</RequestId>
        </ResponseMetadata>
      </SetSubscriptionAttributesResponse> 
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :set_subscription_attributes)
    assert parsed_doc[:request_id] == "a8763b99-33a7-11df-a9b7-05d48da6f042"
  end


  test "#parsing a get_endpoint_attributes response" do
    rsp = """
      <GetEndpointAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <GetEndpointAttributesResult>
          <Attributes>
            <entry>
              <key>Enabled</key>
              <value>true</value>
            </entry>
            <entry>
              <key>CustomUserData</key>
              <value>UserId=01234567</value>
            </entry>
            <entry>
              <key>Token</key>
              <value>APA91bGi7fFachkC1xjlqT66VYEucGHochmf1VQAr9k...jsM0PKPxKhddCzx6paEsyay9Zn3D4wNUJb8m6HZrBEXAMPLE</value>
            </entry>
          </Attributes>
        </GetEndpointAttributesResult>
        <ResponseMetadata>
          <RequestId>6c725a19-a142-5b77-94f9-1055a9ea04e7</RequestId>
        </ResponseMetadata>
      </GetEndpointAttributesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :get_endpoint_attributes)
    assert parsed_doc[:enabled] == true
    assert parsed_doc[:custom_user_data] == "UserId=01234567"
    assert parsed_doc[:token] == "APA91bGi7fFachkC1xjlqT66VYEucGHochmf1VQAr9k...jsM0PKPxKhddCzx6paEsyay9Zn3D4wNUJb8m6HZrBEXAMPLE"
    assert parsed_doc[:request_id] == "6c725a19-a142-5b77-94f9-1055a9ea04e7"
  end

  test "#parsing a set_endpoint_attributes response" do
    rsp = """
      <SetEndpointAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>2fe0bfc7-3e85-5ee5-a9e2-f58b35e85f6a</RequestId>
        </ResponseMetadata>
      </SetEndpointAttributesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :set_endpoint_attributes)
    assert parsed_doc[:request_id] == "2fe0bfc7-3e85-5ee5-a9e2-f58b35e85f6a"
  end

  test "#parsing a delete_endpoint response" do
    rsp = """
      <DeleteEndpointResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
        <ResponseMetadata>
          <RequestId>c1d2b191-353c-5a5f-8969-fbdd3900afa8</RequestId>
        </ResponseMetadata>
      </DeleteEndpointResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :delete_endpoint)
    assert parsed_doc[:request_id] == "c1d2b191-353c-5a5f-8969-fbdd3900afa8"
  end

  test "it should handle parsing an error" do
    rsp = """
    <?xml version=\"1.0\"?>
    <ErrorResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">
      <Error>
        <Type>Sender</Type>
        <Code>ExpiredToken</Code>
        <Message>The security token included in the request is expired</Message>
        <Detail/>
      </Error>
      <RequestId>f7ac5905-2fb6-5529-a86d-09628dae67f4</RequestId>
    </ErrorResponse>
    """
    |> to_error

    {:error, {:http_error, 403, err}} = Parsers.parse(rsp, :set_endpoint_attributes)

    assert "f7ac5905-2fb6-5529-a86d-09628dae67f4" == err[:request_id]
    assert "Sender" == err[:type]
    assert "ExpiredToken" == err[:code]
    assert "The security token included in the request is expired" == err[:message]
  end
end
