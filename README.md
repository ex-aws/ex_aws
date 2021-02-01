# ExAws

<!-- MDOC !-->

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/ex-aws/ex_aws/on-push)
[![hex.pm](https://img.shields.io/hexpm/v/ex_aws.svg)](https://hex.pm/packages/ex_aws)
[![hex.pm](https://img.shields.io/hexpm/dt/ex_aws.svg)](https://hex.pm/packages/ex_aws)
[![hex.pm](https://img.shields.io/hexpm/l/ex_aws.svg)](https://hex.pm/packages/ex_aws)
[![hexdocs.pm](https://img.shields.io/badge/hexdocs-release-lightgreen.svg)](https://hexdocs.pm/ex_aws)
[![github.com](https://img.shields.io/github/last-commit/ex-aws/ex_aws.svg)](https://github.com/ex-aws/ex_aws/commits/master)

A flexible easy to use set of AWS APIs.

Available Services: https://github.com/ex-aws?q=service&type=&language=

## Un-Deprecation Notice

ExAws is now actively maintained again :). It's going to take me a while to work through
all the outstanding issues and PRs, so please bear with me.

- Bernard

## Getting Started

ExAws v2.0 breaks out every service into its own package. To use the S3
service, you need both the core `:ex_aws` package as well as the `:ex_aws_s3`
package.

As with all ExAws services, you'll need a compatible HTTP client (defaults to
`:hackney`) and whatever JSON or XML codecs needed by the services you want to
use. Consult individual service documentation for details on what each service
needs.

```elixir
defp deps do
  [
    {:ex_aws, "~> 2.1"},
    {:ex_aws_s3, "~> 2.0"},
    {:hackney, "~> 1.9"},
    {:sweet_xml, "~> 0.6"},
  ]
end
```

With these deps you can use `ExAws` precisely as you're used to:

```
# make a request (with the default region)
ExAws.S3.list_objects("my-bucket") |> ExAws.request()

# or specify the region
ExAws.S3.list_objects("my-bucket") |> ExAws.request(region: "us-west-1")

# some operations support streaming
ExAws.S3.list_objects("my-bucket") |> ExAws.stream!() |> Enum.to_list()
```

### AWS Key configuration

ExAws requires valid AWS keys in order to work properly. ExAws by default does
the equivalent of:

```elixir
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
```

This means it will try to resolve credentials in order:

* Look for the AWS standard `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
* Resolve credentials with IAM
  * If running inside ECS and a [task role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) has been assigned it will use it
  * Otherwise it will fall back to the [instance role](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)

AWS CLI config files are supported, but require an additional dependency:

```elixir
{:configparser_ex, "~> 2.0"}
```

You can then add `{:awscli, "profile_name", timeout}` to the above config and
it will pull information from `~/.aws/config` and `~/.aws/credentials`

Alternatively, if you already have a profile name set in the `AWS_PROFILE` environment
variable, you can use that with `{:awscli, :system, timeout}`

```elixir
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, {:awscli, "default", 30}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role]
```

For role based authentication via `role_arn` and `source_profile` an additional
dependency is required:

```elixir
{:ex_aws_sts, "~> 2.0"}
```

Further information on role based authentication is provided in said dependency.

### Hackney configuration

ExAws by default uses [hackney](https://github.com/benoitc/hackney) to make
HTTP requests to AWS API. You can modify the options as such:

```elixir
config :ex_aws, :hackney_opts,
  follow_redirect: true,
  recv_timeout: 30_000
```

### AWS Region Configuration.

You can set the region used by default for requests.

```elixir
config :ex_aws,
  region: "us-west-2",
```

Alternatively, the region can be set in an environment variable:

```elixir
config :ex_aws,
  region: {:system, "AWS_REGION"}
```

### JSON Codec Configuration

The default JSON codec is Poison.  You can choose a different one:

```elixir
config :ex_aws,
  json_codec: Jason
```

### Path Normalization

Paths that include multiple consecutive /'s will by default be normalized
to a single slash. There are cases when paths need to be literal (S3) and
this normalization behaviour can be turned off via configuration:

```elixir
config :ex_aws,
  normalize_path: false
```

## Direct Usage

ExAws can also be used directly without any specific service module.

You need to figure out how the API of the specific AWS service works, in particular:

- Protocol (JSON or query).
- Path (depends on the service and the specific operation, usually "/").
- Service name (used to generate the request signature,
  [as described here](https://docs.aws.amazon.com/general/latest/gr/sigv4-create-string-to-sign.html)).
- Request body, query params, HTTP method, and headers (depends on the service
  and specific operation).

You can look for this information in the service's API reference at
[docs.aws.amazon.com](https://docs.aws.amazon.com/index.html) or, for example,
in the Go SDK API models at [github.com/aws/aws-sdk-go](https://github.com/aws/aws-sdk-go/tree/master/models/apis) (look for a `api-*.json` file).

The protocol dictates which operation module to use for the request. If the
protocol is JSON, use `ExAws.Operation.JSON`, if it's query, use
`ExAws.Operation.Query`.

### Examples

#### Redshift DescribeClusters

```elixir
action = :describe_clusters
action_string = action |> Atom.to_string |> Macro.camelize

operation =
  %ExAws.Operation.Query{
    path: "/",
    params: %{"Action" => action_string},
    service: :redshift,
    action: action
  }

ExAws.request(operation)
```

#### ECS RunTask

```elixir
data = %{
  taskDefinition: "hello_world",
  launchType: "FARGATE",
  networkConfiguration: %{
    awsvpcConfiguration: %{
      subnets: ["subnet-1a2b3c4d", "subnet-4d3c2b1a"],
      securityGroups: ["sg-1a2b3c4d"],
      assignPublicIp: "ENABLED"
    }
  }
}

operation =
  %ExAws.Operation.JSON{
    http_method: :post,
    headers: [
      {"x-amz-target", "AmazonEC2ContainerServiceV20141113.RunTask"},
      {"content-type", "application/x-amz-json-1.1"}
    ],
    path: "/",
    data: data,
    service: :ecs
}

ExAws.request(operation)
```

## Highlighted Features

- Easy configuration.
- Minimal dependencies. Choose your favorite JSON codec and HTTP client.
- Elixir streams to automatically retrieve paginated resources.
- Elixir protocols allow easy customization of Dynamo encoding / decoding.
- `mix aws.kinesis.tail your-stream-name` task for easily watching the contents
  of a kinesis stream.
- Simple. ExAws aims to provide a clear and consistent elixir wrapping around
  AWS APIs, not abstract them away entirely. For every action in a given AWS
  API there is a corresponding function within the appropriate module. Higher
  level abstractions like the aforementioned streams are in addition to and not
  instead of basic API calls.

That's it!

## Retries

ExAws will retry failed AWS API requests using exponential backoff per the
"Full Jitter" formula described in
https://www.awsarchitectureblog.com/2015/03/backoff.html

The algorithm uses three values, which are configurable:

```elixir
# default values shown below

config :ex_aws, :retries,
  max_attempts: 10,
  base_backoff_in_ms: 10,
  max_backoff_in_ms: 10_000
```

* `max_attempts` is the maximum number of possible attempts with backoffs in between each one
* `base_backoff_in_ms` corresponds to the `base` value described in the blog post
* `max_backoff_in_ms` corresponds to the `cap` value described in the blog post

## Testing

If you want to run `mix test`, you'll need to have a local `dynamodb` running
on port 8000.  See [Setting up DynamoDB Local](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html).

The redirect test will intentionally cause a warning to be issued.

## License

The MIT License (MIT)

Copyright (c) 2014-2020 CargoSense, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
