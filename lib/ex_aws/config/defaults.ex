defmodule ExAws.Config.Defaults do
  def get do
    [
      access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
      secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
      http_client: ExAws.Request.HTTPoison,
      json_codec: Poison,
      kinesis: [
        scheme: "https://",
        host: {"$region", "kinesis.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      dynamodb: [
        scheme: "https://",
        host: {"$region", "dynamodb.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      lambda: [
        host: {"$region", "lambda.$region.amazonaws.com"},
        scheme: "https://",
        region: "us-east-1",
        port: 80
      ],
      s3: [
        scheme: "https://",
        host: %{
          "us-east-1" => "s3.amazonaws.com",
          "us-west-1" => "s3-us-west-1.amazonaws.com",
          "us-west-2" => "s3-us-west-2.amazonaws.com",
          "eu-west-1" => "s3-eu-west-1.amazonaws.com",
          "eu-central-1" => "s3-eu-central-1.amazonaws.com",
          "ap-southeast-1" => "s3-ap-southeast-1.amazonaws.com",
          "ap-southeast-2" => "s3-ap-southeast-2.amazonaws.com",
          "ap-northeast-1" => "s3-ap-northeast-1.amazonaws.com",
          "sa-east-1" => "s3-sa-east-1.amazonaws.com",
        },
        region: "us-east-1"
      ],
      sqs: [
        scheme: "https://",
        host: {"$region", "sqs.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      ec2: [
        scheme: "https://",
        host: {"$region", "ec2.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      rds: [
        scheme: "https://",
        host: {"$region", "rds.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      sns: [
        host: "sns.us-east-1.amazonaws.com",
        scheme: "https://",
        region: "us-east-1"
      ]
    ]
  end
end
