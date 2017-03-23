Contributing
============

## Updates for 1.0

The organizational structure of ExAws has been greatly simplified as we move into 1.0. Please read this document carefully as it has changed.

Contributions to ExAws are absolutely appreciated. For general bug fixes or other tweaks to existing code, a regular pull request is fine. For those who wish to add to the set of APIs supported by ExAws, please consult the rest of this document, as any PRs adding a service are expected to follow the structure defined herein.

## Running Tests
Running the test suite for ex_aws requires a few things:

1. DynamoDB Local must be running
  * May be downloaded from http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
  * And may be executed with `java -Djava.library.path=/DynamoDBLocal_lib -jar DynamoDBLocal.jar -inMemory`
2. Requires two environment variables `AWS_ACCESS_KEY_ID`, and `AWS_SECRET_ACCESS_KEY`
  * These must be valid AWS credentials, the minimum IAM permissions required are:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:ListStreams",
        "route53:ListHostedZones",
        "kinesis:ListStreams",
        "lambda:ListFunctions",
        "s3:ListAllMyBuckets",
        "sns:ListTopics",
        "sqs:ListQueues",
        "ec2:DescribeInstances",
        "firehose:ListDeliveryStreams",
        "ses:VerifyEmailIdentity",
        "elastictranscoder:ListPipelines"
      ],
      "Resource": "*"
    }
  ]
}
```

The test suite can be run with `AWS_ACCESS_KEY_ID=your-aws-access-key AWS_SECRET_ACCESS_KEY=your-aws-secret-access-key mix test`

### Key Management Service

If running integrate test for Key Management Service. Require an environment variable `TEST_EX_AWS_KEY_ARN`. Please set new CMK to `TEST_EX_AWS_KEY_ARN` for integrate test.

## Organization

ExAws 1.0.0 takes a more data driven approach to querying APIs. The various functions that exist inside a service like `S3.list_objects` or `Dynamo.create_table` all return a struct which holds the information necessary to make that particular operation. Creating a service module then is very easy, as you just need to create functions which return an operations struct, and you're done. If there is not yet an operations struct applicable to the desired service, creating one of those isn't too bad either. See the relevant sections below.

Often the same struct is used across several services if those services have the same underlying request characteristics. For example Dynamo, Kinesis, and Lambda all use the JSON operation.

The `ExAws.Operation` protocol is implemented for each operation struct, giving us `perform` and `stream` functions. The `perform/2` function operations basically like the service specific `request` functions that existed pre 1.0. They take the operation struct and any configuration overrides, do any service specific steps that require configuration, and then call the `ExAws.request` module.

The `stream` function generally calls a function contained in the operation struct with the operation and config, returning a stream that can be later consumed.

## Creating a New Service

In progress. Please see any of the existing services by way of example.

## Creating a New Operation

In progress. Please see any of the existing operations by way of example.
