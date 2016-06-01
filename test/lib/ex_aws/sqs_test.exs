defmodule ExAws.SQSTest do
  use ExUnit.Case, async: true
  alias ExAws.SQS

  test "#create_queue" do
    expected = %{"Action" => "CreateQueue", "Attribute.1.Name" => "VisibilityTimeout", "Attribute.1.Value" => 10, "QueueName" => "test_queue"}
    assert expected == SQS.create_queue("test_queue", visibility_timeout: 10).params
  end

  test "#delete_queue" do
    expected = %{"Action" => "DeleteQueue"}
    assert expected == SQS.delete_queue("982071696186/test_queue").params
  end

  test "#list_queues" do
    expected = %{"Action" => "ListQueues"}
    assert expected == SQS.list_queues.params
  end

  test "#get_queue_attributes" do
    expected = %{"Action" => "GetQueueAttributes", "AttributeName.1" => "All"}
    assert expected == SQS.get_queue_attributes("982071696186/test_queue").params

    expected =  %{"Action" => "GetQueueAttributes", "AttributeName.1" => "VisibilityTimeout", "AttributeName.2" => "MessageRetentionPeriod"}
    assert expected == SQS.get_queue_attributes("982071696186/test_queue", [:visibility_timeout, :message_retention_period]).params
  end

  test "#set_queue_attributes" do
    expected = %{"Action" => "SetQueueAttributes", "Attribute.1.Name" => "VisibilityTimeout", "Attribute.1.Value" => 10}
    assert expected == SQS.set_queue_attributes("982071696186/test_queue", visibility_timeout: 10).params
  end

  test "#purge_queue" do
    expected = %{"Action" => "PurgeQueue"}
    assert expected == SQS.purge_queue("982071696186/test_queue").params
  end

  test "#list_dead_letter_source_queues" do
    expected = %{"Action" => "ListDeadLetterSourceQueues"}
    assert expected == SQS.list_dead_letter_source_queues("982071696186/test_queue").params
  end

  test "#add_permission" do
    expected = %{
      "Action" => "AddPermission",
      "Label" => "TestAddPermission",
      "AWSAccountId.1" => "681962096817",
      "ActionName.1" => "*",
      "AWSAccountId.2" => "071669896281",
      "ActionName.2" => "SendMessage",
      "AWSAccountId.3" => "071669896281",
      "ActionName.3" => "ReceiveMessage"
    }

    assert expected == SQS.add_permission("982071696186/test_queue", "TestAddPermission", %{"681962096817" => :all, "071669896281" => [:send_message, :receive_message]}).params
  end

  test "#remove_permission" do
    expected = %{"Action" => "RemovePermission", "Label" => "TestAddPermission"}

    assert expected == SQS.remove_permission("982071696186/test_queue", "TestAddPermission").params
  end

  test "#send_message" do
    expected = %{"Action" => "SendMessage",
                 "MessageBody" => "This is the message body.",
                 "DelaySeconds" => 30,
                 "MessageAttribute.1.Name" => "TestStringAttribute",
                 "MessageAttribute.1.Value.StringValue" => "testing!",
                 "MessageAttribute.1.Value.DataType" => "String",
                 "MessageAttribute.2.Name" => "TestBinaryAttribute",
                 "MessageAttribute.2.Value.BinaryValue" => <<31, 139, 8, 0, 0, 0, 0, 0, 0, 3, 43, 73, 45, 46, 201, 204, 75, 87, 4, 0, 188, 169, 224, 119, 8, 0, 0, 0>>,
                 "MessageAttribute.2.Value.DataType" => "Binary",
                 "MessageAttribute.3.Name" => "TestNumberAttribute",
                 "MessageAttribute.3.Value.StringValue" => 42,
                 "MessageAttribute.3.Value.DataType" => "Number",
                 "MessageAttribute.4.Name" => "TestCustomNumberAttribute",
                 "MessageAttribute.4.Value.StringValue" => 7,
                 "MessageAttribute.4.Value.DataType" => "Number.Prime"
                 }

    assert expected == SQS.send_message(
                         "982071696186/test_queue",
                         "This is the message body.",
                         [
                           delay_seconds: 30,
                           message_attributes: [
                             %{
                               name: "TestStringAttribute",
                               data_type: :string,
                               value: "testing!"
                             },
                             %{
                                name: "TestBinaryAttribute",
                                data_type: :binary,
                                value: :zlib.gzip("testing!")
                              },
                              %{
                                name: "TestNumberAttribute",
                                data_type: :number,
                                value: 42
                              },
                              %{
                                name: "TestCustomNumberAttribute",
                                data_type: :number,
                                custom_type: "Prime",
                                value: 7
                              }
                           ]
                         ]).params
  end

  test "#send_message_batch" do
    expected = %{"Action" => "SendMessageBatch",
                 "SendMessageBatchRequestEntry.1.Id" => "test_message_1",
                 "SendMessageBatchRequestEntry.1.MessageBody" => "This is the message body.",
                 "SendMessageBatchRequestEntry.1.DelaySeconds" => 30,
                 "SendMessageBatchRequestEntry.1.MessageAttribute.1.Name" => "TestStringAttribute",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.1.Value.StringValue" => "testing!",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.1.Value.DataType" => "String",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.2.Name" => "TestBinaryAttribute",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.2.Value.BinaryValue" => <<31, 139, 8, 0, 0, 0, 0, 0, 0, 3, 43, 73, 45, 46, 201, 204, 75, 87, 4, 0, 188, 169, 224, 119, 8, 0, 0, 0>>,
                 "SendMessageBatchRequestEntry.1.MessageAttribute.2.Value.DataType" => "Binary",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.3.Name" => "TestNumberAttribute",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.3.Value.StringValue" => 42,
                 "SendMessageBatchRequestEntry.1.MessageAttribute.3.Value.DataType" => "Number",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.4.Name" => "TestCustomNumberAttribute",
                 "SendMessageBatchRequestEntry.1.MessageAttribute.4.Value.StringValue" => 7,
                 "SendMessageBatchRequestEntry.1.MessageAttribute.4.Value.DataType" => "Number.Prime",
                 "SendMessageBatchRequestEntry.2.Id" => "test_message_2",
                 "SendMessageBatchRequestEntry.2.MessageBody" => "This is the second message body.",
                 "SendMessageBatchRequestEntry.2.MessageAttribute.1.Name" => "TestAnotherStringAttribute",
                 "SendMessageBatchRequestEntry.2.MessageAttribute.1.Value.StringValue" => "still testing!",
                 "SendMessageBatchRequestEntry.2.MessageAttribute.1.Value.DataType" => "String",
                 }

    assert expected == SQS.send_message_batch(
                         "982071696186/test_queue",
                         [
                           [ id: "test_message_1",
                             message_body: "This is the message body.",
                             delay_seconds: 30,
                             message_attributes: [
                               %{
                                 name: "TestStringAttribute",
                                 data_type: :string,
                                 value: "testing!"
                               },
                               %{
                                  name: "TestBinaryAttribute",
                                  data_type: :binary,
                                  value: :zlib.gzip("testing!")
                                },
                                %{
                                  name: "TestNumberAttribute",
                                  data_type: :number,
                                  value: 42
                                },
                                %{
                                  name: "TestCustomNumberAttribute",
                                  data_type: :number,
                                  custom_type: "Prime",
                                  value: 7
                                }
                             ]
                           ],
                           [
                             id: "test_message_2",
                             message_body: "This is the second message body.",
                             message_attributes: [
                               %{
                                 name: "TestAnotherStringAttribute",
                                 data_type: :string,
                                 value: "still testing!"
                               }
                             ]
                           ]
                         ]
                       ).params
  end

  test "#receive_message" do
    expected = %{"Action" => "ReceiveMessage"}
    assert expected == SQS.receive_message("982071696186/test_queue").params

    expected = %{"Action" => "ReceiveMessage", "AttributeName.1" => "All", "MaxNumberOfMessages" => 5}
    assert expected == SQS.receive_message("982071696186/test_queue", attribute_names: :all,
                                                                      max_number_of_messages: 5).params

    expected = %{"Action" => "ReceiveMessage", "AttributeName.1" => "SenderId", "AttributeName.2" => "ApproximateReceiveCount", "VisibilityTimeout" => 1000, "WaitTimeout" => 20}
    assert expected == SQS.receive_message("982071696186/test_queue", attribute_names: [:sender_id, :approximate_receive_count],
                                                                      visibility_timeout: 1000,
                                                                      wait_timeout: 20).params
  end

  test "#delete_message" do
    expected = %{"Action" => "DeleteMessage", "ReceiptHandle" => "AQEB0aw+z96sMOUWLQuIzA7nPHS7zUOIRlV0OEqvDoKtNcHxSVDQEfY0gBOJKGcnyTvIUncpimPv0CfQDFbwmdU9E00793cP19Bx8BqzuS0sNrARyY4M4xVi7ceVYHMSNU1uyF/+sK6u8yAGnsbsgmPg4AUs5oapv5Qawiq5HJGgH3cmRPy5/IW+b9W6HVy//uNzejbIcAjQX58Dd79D4AGb9Iu4dqfEVK7zo5BCTy+pz9hqGf5MT3jkrd5umjwGdrg3sVBYhrLjmgaqftON8JclkmrUJk0LzPwQ4DdpT8oz5mh7VzAjRXkIA0IQ8PGFFGPMIb8gWNzJ4KA4/OYlnDYyGw=="}
    assert expected == SQS.delete_message("982071696186/test_queue", "AQEB0aw+z96sMOUWLQuIzA7nPHS7zUOIRlV0OEqvDoKtNcHxSVDQEfY0gBOJKGcnyTvIUncpimPv0CfQDFbwmdU9E00793cP19Bx8BqzuS0sNrARyY4M4xVi7ceVYHMSNU1uyF/+sK6u8yAGnsbsgmPg4AUs5oapv5Qawiq5HJGgH3cmRPy5/IW+b9W6HVy//uNzejbIcAjQX58Dd79D4AGb9Iu4dqfEVK7zo5BCTy+pz9hqGf5MT3jkrd5umjwGdrg3sVBYhrLjmgaqftON8JclkmrUJk0LzPwQ4DdpT8oz5mh7VzAjRXkIA0IQ8PGFFGPMIb8gWNzJ4KA4/OYlnDYyGw==").params
  end

  test "#delete_message_batch" do
    expected = %{"Action" => "DeleteMessageBatch",
                 "DeleteMessageBatchRequestEntry.1.Id" => "message_1",
                 "DeleteMessageBatchRequestEntry.1.ReceiptHandle" => "AQEBlA6/i+8F3P6lA7y3msc8dINnF+b3VgTX71nMWw7VvbHc8mdGFyZjVAVMH/rg6Vyc00O2Tl2ZyKn8IPUiy6n44ipop+xb33XNU/cABvVWZogNN95b9mmR6RuSA0dcVmFL02TwZDpg7cMOWNhYThEp+a5atsG85PX7V6q9zBklltBSQnT6r9QSngnv2m1C23jfFYow0oy86cofp0mQ4z5ez9bWmlHa4XfpZUpP2KVlBCDgyR0tQQRGt170foph32Cg+Bp6RRv9Tyo7aVWqM4OT/CHTJ0ZPiAYoH8MYFxjUaqoeKhUwDFq36trQxrBq9BfBj+hrzEtDQdxcNZM2pZi2xQ==",
                 "DeleteMessageBatchRequestEntry.2.Id" => "message_2",
                 "DeleteMessageBatchRequestEntry.2.ReceiptHandle" => "AQEBc8vuFKIpTF3ESXTpxc2+vARUXHpGzup9YwTMD7Alibe/z/yXEPaXY4ZtTUvInYfEazLhughdoLGSEh1SDPsIdDB9Os8D84xHmtXelswA7FBXEdNunRk4wg6Zi4jgjEy3Kyy9cGpiZwRxw4Vy4PrK7H0BbH07k+mVby8P8B9m97GO/w666/zU46QpFB6jhi7L0d76AW16/PMzEBbDB6zUvXiYUAMmxvdppYrcYqb22K0gWvZsL1Dogr592k/fA1W2oF1YsjTSn9FjYr/q5XK1Z1Lvvmh3/20D5U0qjnFd4wg9MlVp8zrBg2mNoVl6QEHPNP/zA+dZg2d/6SSgEdI1hQ=="}

    assert expected == SQS.delete_message_batch("982071696186/test_queue", [
                        %{
                          id: "message_1",
                          receipt_handle: "AQEBlA6/i+8F3P6lA7y3msc8dINnF+b3VgTX71nMWw7VvbHc8mdGFyZjVAVMH/rg6Vyc00O2Tl2ZyKn8IPUiy6n44ipop+xb33XNU/cABvVWZogNN95b9mmR6RuSA0dcVmFL02TwZDpg7cMOWNhYThEp+a5atsG85PX7V6q9zBklltBSQnT6r9QSngnv2m1C23jfFYow0oy86cofp0mQ4z5ez9bWmlHa4XfpZUpP2KVlBCDgyR0tQQRGt170foph32Cg+Bp6RRv9Tyo7aVWqM4OT/CHTJ0ZPiAYoH8MYFxjUaqoeKhUwDFq36trQxrBq9BfBj+hrzEtDQdxcNZM2pZi2xQ=="
                        },
                        %{
                          id: "message_2",
                          receipt_handle: "AQEBc8vuFKIpTF3ESXTpxc2+vARUXHpGzup9YwTMD7Alibe/z/yXEPaXY4ZtTUvInYfEazLhughdoLGSEh1SDPsIdDB9Os8D84xHmtXelswA7FBXEdNunRk4wg6Zi4jgjEy3Kyy9cGpiZwRxw4Vy4PrK7H0BbH07k+mVby8P8B9m97GO/w666/zU46QpFB6jhi7L0d76AW16/PMzEBbDB6zUvXiYUAMmxvdppYrcYqb22K0gWvZsL1Dogr592k/fA1W2oF1YsjTSn9FjYr/q5XK1Z1Lvvmh3/20D5U0qjnFd4wg9MlVp8zrBg2mNoVl6QEHPNP/zA+dZg2d/6SSgEdI1hQ=="
                        }
                       ]).params
  end

  test "#change_message_visibility" do
    expected = %{"Action" => "ChangeMessageVisibility",
                 "ReceiptHandle" => "AQEBS52UqQL7wJo1I21OqVBXTbxZa0WrHqKntw/N4YtYblV3mix7BkEQVM16K9WABAM9q6AKqjiuTPQAmhqRz2+pw02QuNB5kUn2hpSLVTasAkcTMPgFfLFEufBxGR2hxGeOvP/XDO3DPGnQO3WvOSJTxQKitwT9xWDWAZgm96Ra1pnduckZkLTWolj+34okJqQTDVAL7/Br4BEtgHQXJKm5BCfry8jA1XYjy5IjyB2syLihdgVU0qBLxlGDDhuCOW5eNQiVig3v0oa7SVvRKzMK4bMor1Y17wSETo6y0gYb1QtD1rBUpoKAeq49gpKjBnAkMdHV/DFAfRAtcJNcsPpiQA==",
                 "VisibilityTimeout" => 300}

    assert expected == SQS.change_message_visibility("982071696186/test_queue",
                                                     "AQEBS52UqQL7wJo1I21OqVBXTbxZa0WrHqKntw/N4YtYblV3mix7BkEQVM16K9WABAM9q6AKqjiuTPQAmhqRz2+pw02QuNB5kUn2hpSLVTasAkcTMPgFfLFEufBxGR2hxGeOvP/XDO3DPGnQO3WvOSJTxQKitwT9xWDWAZgm96Ra1pnduckZkLTWolj+34okJqQTDVAL7/Br4BEtgHQXJKm5BCfry8jA1XYjy5IjyB2syLihdgVU0qBLxlGDDhuCOW5eNQiVig3v0oa7SVvRKzMK4bMor1Y17wSETo6y0gYb1QtD1rBUpoKAeq49gpKjBnAkMdHV/DFAfRAtcJNcsPpiQA==",
                                                     300).params
  end

  test "#change_message_visibility_batch" do
    expected = %{"Action" => "ChangeMessageVisibilityBatch",
                 "ChangeMessageVisibilityBatchRequestEntry.1.Id" => "message_1",
                 "ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle" => "AQEBnLhpyRJrHQrnrj9KdMD2PjD5XJdb26X12vvOvZuqoa/i1LGSq4JO7HHmoXGbrn04Zi4jTb4yQGywI/Q1yah/kPgLQuiOAHlnPvypRmKeToeJoHA75bduoC0o8rCokcQtTy9ZGIBM/WlnrND4Cs0Zie7KJEEq4LxDb9xivphZp1vjXTwActAwCN6jk4rSlyXaLTgYoeeugjm4RoM0Vq+iSQX/vksNAkEy2pjZWg3/K8v8/2JQZtop6F6JjcaRlhRYSKvwSu0Xjh3U3QJhXaWZL0u9e08k16g8pE5Q/5s50Gjo9qTkDFUdJVBmFdiyccH1afkkwgYQ4/TJ9j/wR2jQRA==",
                 "ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout" => 300,
                 "ChangeMessageVisibilityBatchRequestEntry.2.Id" => "message_2",
                 "ChangeMessageVisibilityBatchRequestEntry.2.ReceiptHandle" => "AQEBpi/Z/1G3YBXa24a9beh4WwXFMJLNcd9bNVnfz1GKQIs/LlgzUf12jnyV7SquZIJ2KSkxnIVd4w6mGxCFGg/esrgk0xmu53QRWxCJ3HSa1RGpb+cJ/nNbgRFG1DIo1/njuG+sCZ66VFgsCz8tAtjEKNAndVgT9RDpRjvD+Xb+Ud4Z66izJs5ubeXpCTaq6tiBTmgC6VAUsOzH3d7WelmZTKnDG/3+nHmZnP3/9PJwwx1dzJDtZdOrNJ3w5dRPOpKAfxsgPTMl+5Vcd0xpaA6jEC9IvLakvw1OgqadLwUaS90GJr4GjHBevSDh+2fe8jub6BoCM3nzixlYKEZwdPVORw==",
                 "ChangeMessageVisibilityBatchRequestEntry.2.VisibilityTimeout" => 600}


    result = SQS.change_message_visibility_batch("982071696186/test_queue", [
      %{
        id: "message_1",
        receipt_handle: "AQEBnLhpyRJrHQrnrj9KdMD2PjD5XJdb26X12vvOvZuqoa/i1LGSq4JO7HHmoXGbrn04Zi4jTb4yQGywI/Q1yah/kPgLQuiOAHlnPvypRmKeToeJoHA75bduoC0o8rCokcQtTy9ZGIBM/WlnrND4Cs0Zie7KJEEq4LxDb9xivphZp1vjXTwActAwCN6jk4rSlyXaLTgYoeeugjm4RoM0Vq+iSQX/vksNAkEy2pjZWg3/K8v8/2JQZtop6F6JjcaRlhRYSKvwSu0Xjh3U3QJhXaWZL0u9e08k16g8pE5Q/5s50Gjo9qTkDFUdJVBmFdiyccH1afkkwgYQ4/TJ9j/wR2jQRA==",
        visibility_timeout: 300
      },
      %{
        id: "message_2",
        receipt_handle: "AQEBpi/Z/1G3YBXa24a9beh4WwXFMJLNcd9bNVnfz1GKQIs/LlgzUf12jnyV7SquZIJ2KSkxnIVd4w6mGxCFGg/esrgk0xmu53QRWxCJ3HSa1RGpb+cJ/nNbgRFG1DIo1/njuG+sCZ66VFgsCz8tAtjEKNAndVgT9RDpRjvD+Xb+Ud4Z66izJs5ubeXpCTaq6tiBTmgC6VAUsOzH3d7WelmZTKnDG/3+nHmZnP3/9PJwwx1dzJDtZdOrNJ3w5dRPOpKAfxsgPTMl+5Vcd0xpaA6jEC9IvLakvw1OgqadLwUaS90GJr4GjHBevSDh+2fe8jub6BoCM3nzixlYKEZwdPVORw==",
        visibility_timeout: 600
      }
    ])

    assert result.path == "/982071696186/test_queue"
    assert result.params == expected
  end
end
