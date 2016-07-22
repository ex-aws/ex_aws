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

  test "#publish" do
    expected = %{
      "Action" => "Publish",
      "Message" => "{\"message\": \"MyMessage\"}",
      "TopicArn" => "arn:aws:sns:us-east-1:982071696186:test-topic"
    }
    assert expected == SNS.publish("{\"message\": \"MyMessage\"}", [topic_arn: "arn:aws:sns:us-east-1:982071696186:test-topic"]).params
  end
end
