defmodule ExAws.SNSTest do
  use ExUnit.Case, async: true
  alias ExAws.SNS

  test "#list_topics" do
    expected = %{"Action" => "ListTopics"}
    assert expected == SNS.list_topics().params
  end

  test "#create_topic" do
    expected = %{"Action" => "CreateTopic", "Name" => "test_topic"}
    assert expected == SNS.create_topic("test_topic").params
  end

  test "#get_topic_attributes" do
    expected = %{"Action" => "GetTopicAttributes", "TopicArn" => "arn:aws:sns:us-east-1:982071696186:test-topic"}
    assert expected == SNS.get_topic_attributes("arn:aws:sns:us-east-1:982071696186:test-topic").params
  end

  test "#set_topic_attributes" do
    expected = %{
      "Action" => "SetTopicAttributes",
      "AttributeName" => "DeliverPolicy",
      "AttributeValue" => "{\"http\":{\"defaultHealthyRetryPolicy\":{\"numRetries\":5}}}",
      "TopicArn" => "arn:aws:sns:us-east-1:982071696186:test-topic"
    }
    assert expected == SNS.set_topic_attributes(:deliver_policy, "{\"http\":{\"defaultHealthyRetryPolicy\":{\"numRetries\":5}}}", "arn:aws:sns:us-east-1:982071696186:test-topic").params
  end

  test "#delete_topic" do
    expected = %{"Action" => "DeleteTopic", "TopicArn" => "arn:aws:sns:us-east-1:982071696186:test-topic"}
    assert expected == SNS.delete_topic("arn:aws:sns:us-east-1:982071696186:test-topic").params
  end

  test "#create_platform_application" do
    expected = %{
      "Action" => "CreatePlatformApplication",
      "Name" => "ApplicationName",
      "Platform" => "APNS"
    }
    assert expected == SNS.create_platform_application("ApplicationName", "APNS").params
  end

  test "#delete_platform_application" do
    expected = %{
      "Action" => "DeletePlatformApplication",
      "PlatformApplicationArn" => "test-endpoint-arn"
    }
    assert expected == SNS.delete_platform_application("test-endpoint-arn").params
  end

  test "#create_platform_endpoint" do
    expected = %{
      "Action" => "CreatePlatformEndpoint",
      "CustomUserData" => "user data",
      "PlatformApplicationArn" => "arn:aws:sns:us-west-1:00000000000:app/APNS/test-arn",
      "Token" => "123abc456def"
    }
    assert expected == SNS.create_platform_endpoint("arn:aws:sns:us-west-1:00000000000:app/APNS/test-arn", "123abc456def", "user data").params
  end

  test "#publish_json" do
    expected = %{
      "Action" => "Publish",
      "Message" => "{\"message\": \"MyMessage\"}",
      "TopicArn" => "arn:aws:sns:us-east-1:982071696186:test-topic"
    }
    assert expected == SNS.publish("{\"message\": \"MyMessage\"}", [topic_arn: "arn:aws:sns:us-east-1:982071696186:test-topic"]).params
  end

  test "#subscribe" do
    expected = %{
      "Action"   => "Subscribe",
      "TopicArn" => "arn:aws:sns:us-east-1:982071696186:test-topic",
      "Protocol" => "https",
      "Endpoint" => "https://example.com"
    }
    assert expected == SNS.subscribe("arn:aws:sns:us-east-1:982071696186:test-topic", "https", "https://example.com").params
  end

  test "#list_subscriptions" do
    expected = %{"Action" => "ListSubscriptions"}
    assert expected == SNS.list_subscriptions().params

    expected = %{"Action" => "ListSubscriptions", "NextToken" => "123456789" }
    assert expected == SNS.list_subscriptions("123456789").params
  end

  # Test SMS request structure. Credentials via (https://www.twilio.com/docs/api/rest/test-credentials).
  test "#publish_sms" do
    expected = %{
      "Action" => "Publish",
      "Message" => "message",
      "MessageAttribute.0.Name" => "AWS.SNS.SMS.SenderID",
      "MessageAttribute.0.Value.DataType" => "String",
      "MessageAttribute.1.Name" => "AWS.SNS.SMS.MaxPrice",
      "MessageAttribute.1.Value.DataType" => "String",
      "MessageAttribute.2.Name" => "AWS.SNS.SMS.SMSType",
      "MessageAttribute.2.Value.DataType" => "String",
      "PhoneNumber" => "+15005550006",
      "MessageAttribute.0.Value.StringValue" => "sender",
      "MessageAttribute.1.Value.StringValue" => "0.8",
      "MessageAttribute.2.Value.StringValue" => "Transactional"
    }

    message_attributes = [
      %{name: "AWS.SNS.SMS.SenderID", data_type: :string, value: {:string, "sender"}},
      %{name: "AWS.SNS.SMS.MaxPrice", data_type: :string, value: {:string, "0.8"}},
      %{name: "AWS.SNS.SMS.SMSType", data_type: :string, value: {:string, "Transactional"}}
    ]
    publish_opts = [
      message_attributes: message_attributes,
      phone_number: "+15005550006"
    ]
    assert expected == SNS.publish("message", publish_opts).params
  end

  test "#get_endpoint_attributes" do
    expected = %{
      "Action" => "GetEndpointAttributes",
      "EndpointArn" => "test-endpoint-arn"
    }
    assert expected == SNS.get_endpoint_attributes("test-endpoint-arn").params
  end

  test "#set_endpoint_attributes" do
    expected = %{
      "Action" => "SetEndpointAttributes",
      "Attributes.entry.1.name" => "Token",
      "Attributes.entry.1.value" => "1234",
      "Attributes.entry.2.name" => "Enabled",
      "Attributes.entry.2.value" => false,
      "Attributes.entry.3.name" => "CustomUserData",
      "Attributes.entry.3.value" => "blah",
      "EndpointArn" => "test-endpoint-arn"
    }
    assert expected == SNS.set_endpoint_attributes("test-endpoint-arn", token: "1234", enabled: false, custom_user_data: "blah").params
  end

  test "#delete_endpoint" do
    expected = %{
      "Action" => "DeleteEndpoint",
      "EndpointArn" => "test-endpoint-arn"
    }
    assert expected == SNS.delete_endpoint("test-endpoint-arn").params
  end
end
