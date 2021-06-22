Contributing
============

ExAws would not be what it is today without the enormous contributions of many people. This document exists to provide a clear direction for those who want to help with this critical part of the Elixir open source community.

Thank you all for your help!

## ExAws v2.0 Architecture

In order to manage the growing size of ExAws, the project has been split up. The `:ex_aws` package itself now consists only of

- Authentication logic
- Request logic
- Core Operations.

To elaborate on that last point, AWS services can be grouped by their broad approach to API building. You've got ones that focus on JSON, ones that combine JSON + REST, older ones that are all query param based, and so on. There are really just a handful of these operation types, and they live here in ExAws itself. They each implement the `ExAws.Operation` protocol, which is what actually drives the request process.

Building these operations by hand however is not always pleasant, so to improve on the experience there are dedicated service modules like `ExAws.Dynamo` or `ExAws.S3` that provide Elixir friendly functions each representing some action on the service. These functions build and return the aforementioned operation structs, which can then be passed to `ExAws.request`.

These service modules now live in their own packages, and have a variety of maintainers. For fixing bugs or adding features to existing services, please simply open a PR or an issue on each service individually.

## Adding a Service

The ExAws organization is happy to accept new services, but be advised that you the contributor are committing to maintain the service. If this is not a responsibility that you want, please simply maintain the code under your own GitHub account.

After you have built a project following the rest of this document, create an issue on the main `ex_aws` project asking for a repo for the project. After one is created, create a PR from your project to the new, empty project. If the review process is succesful it will be merged, and you will be given commit rights on that repository.

### Determine the Operation

As mentioned, ExAws is built around some common operations and thus the first step of adding a new service is figuring out what operation to use. The Go SDK also uses a similar paradigm, and the JSON documents found there are a useful reference. Find the API you want to use in  https://github.com/aws/aws-sdk-go/tree/master/models/apis. If we wanted to build Redshift, we'd go to https://github.com/aws/aws-sdk-go/blob/master/models/apis/redshift/2012-12-01/api-2.json#L6, looking at the `"protocol"` key. In this case it's the `query` protocol so we want the `ExAws.Operation.Query` type.

What this means is that we need every function within our hypothetical `ExAws.Redshift` module to return an `%ExAws.Operation.Query{}` struct.

Note that the mapping from protocol to operation type isn't always one-to-one.
For example, the `"rest-json"` protocol uses the `ExAws.Operation.JSON` type.

### Build a Project

We now need to build a new project.

```bash
$ mix new ex_aws_redshift --module ExAws.Redshift
```

In this project we want a `lib/ex_aws/redshift.ex` file that looks like:

```elixir
defmodule ExAws.Redshift do

  @type describe_cluster_opt :: {:cluster_identifier, String.t}
    | {:marker, String.t}
    | {:max_records, 20..100}
    | {:tags, [String.t]}
  @spec describe_clusters(opts :: [describe_cluster_opt]) :: ExAws.Operation.Query.t
  def describe_clusters(opts \\ []) do
    params = # build params here
    request(:describe_clusters, params)
  end

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/" <> queue,
      params: params |> Map.put("Action", action_string),
      service: :redshift,
      action: action,
      parser: &ExAws.RedShift.Parsers.parse/2
    }
  end
end
```

Notice a few things. The `describe_clusters/0,1` function matches up with the Describe Clusters action found in http://docs.aws.amazon.com/redshift/latest/APIReference/API_DescribeClusters.html. All of the parameters found there are optional, so we put them all in opts. Each of these parameters is given an Elixir friendly name, like `:cluster_identifier` instead of `:ClusterIdentifier`, and the tags are normalized to a nice list of strings instead of the whole `TagKeys.TagKey.N` nonsense. It's up to the function to turn those nice params into what AWS expects.

Finally, we're gonna have a lot of functions that all create the same operation struct, so we extract it into a `request/2` helper function. This helper function also defines a `parser` function. See the SQS for an example of this.

### What about code generation?

Having seen those JSON files in the go SDK you may be wondering if it would be possible to generate all the service modules based on the contents of those JSON files. There is definitely some merit to this idea, and you are more than welcome to try.

Unfortunately however my own (Ben Wilson) efforts at this keep hitting dead ends. It's very hard to typespec everything because AWS will have both `Endpoint` as a type and `endpoint` as a type, whereas Elixir requires all types to be lower case. Trying to generate parsers for the responses had similar issues. Since we're in a dynamic language there's far less need to enforce input shape, AWS validates all that stuff anyway.

For now, it's been simply easier to build helper modules by hand. Who knows, maybe you're up for building ExAws v3.0?

## Formatting and code style

Before opening a PR, please run `mix format` over your changes with a recent Elixir version, and also `mix dialyzer` to make sure you haven't introduced any typing errors.

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
        "elastictranscoder:ListPipelines",
        "cloudwatch:DescribeAlarms",
        "cloudformation:DescribeStacks",
        "cloudformation:ListStacks"
      ],
      "Resource": "*"
    }
  ]
}
```

The test suite can be run with `AWS_ACCESS_KEY_ID=your-aws-access-key AWS_SECRET_ACCESS_KEY=your-aws-secret-access-key mix test`

### Key Management Service

If running integrate test for Key Management Service. Require an environment variable `TEST_EX_AWS_KEY_ARN`. Please set new CMK to `TEST_EX_AWS_KEY_ARN` for integrate test.

## Creating a New Operation

If you find that you need an operation not currently in ExAws, please create an issue.
