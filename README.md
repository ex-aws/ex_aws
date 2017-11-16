ExAws
=====
[![Hex.pm](https://img.shields.io/hexpm/v/ex_aws.svg)](https://hex.pm/packages/ex_aws)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_aws/ExAws.html)
[![Build Status](https://travis-ci.org/CargoSense/ex_aws.svg?branch=master)](https://travis-ci.org/CargoSense/ex_aws)

A flexible easy to use set of AWS APIs.

Available Services: https://github.com/ex-aws?q=service&type=&language=

## Getting Started

ExAws v2.0 breaks out every service into its own package. To use the S3 service, you need both the core `:ex_aws` package as well as the `:ex_aws_s3` package.

As with all ExAws services, you'll need a compatible HTTP client (defaults to `:hackney`) and whatever JSON or XML codecs needed by the services you want to use. Consult individual service documentation for details on what each service needs.

```elixir
defp deps do
  [
    {:ex_aws, "~> 2.0"},
    {:ex_aws_s3, "~> 2.0"},
    {:hackney, "~> 1.9"},
    {:sweet_xml, "~> 0.6"},
  ]
end
```

With these deps you can use `ExAws` precisely as you're used to:

```
# make a request
ExAws.S3.list_objects("my-bucket") |> ExAws.request

# some operations support streaming
ExAws.S3.list_objects("my-bucket") |> ExAws.stream! |> Enum.to_list
```

### AWS Key configuration

ExAws requires valid AWS keys in order to work properly. ExAws by default does the equivalent of:

```elixir
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
```

This means it will try to resolve credentials in order
* Look for the AWS standard `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
* Resolve credentials with IAM
  * If running inside ECS and a [task role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) has been assigned it will use it
  * Otherwise it will fall back to the [instance role](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)

AWS CLI config files are supported, but require an additional dependency:

```elixir
{:configparser_ex, "~> 2.0"}
```

You can then add `{:awscli, "profile_name", timeout}` to the above config and it
will pull information from `~/.aws/config` and `~/.aws/credentials`
```elixir
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, {:awscli, "default", 30}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role],
```

#### Hackney configuration

ExAws by default uses [hackney](https://github.com/benoitc/hackney) to make HTTP requests to AWS API. You can modify the options as such:

```elixir
config :ex_aws, :hackney_opts,
  follow_redirect: true,
  recv_timeout: 30_000
```

## Direct Usage

ExAws can also be used directly without any specific service module.

--TODO--

## Highlighted Features
- Easy configuration.
- Minimal dependencies. Choose your favorite JSON codec and HTTP client.
- Elixir streams to automatically retrieve paginated resources.
- Elixir protocols allow easy customization of Dynamo encoding / decoding.
- `mix kinesis.tail your-stream-name` task for easily watching the contents of a kinesis stream.
- Simple. ExAws aims to provide a clear and consistent elixir wrapping around AWS APIs, not abstract them away entirely. For every action in a given AWS API there is a corresponding function within the appropriate module. Higher level abstractions like the aforementioned streams are in addition to and not instead of basic API calls.

That's it!

## Retries

ExAws will retry failed AWS API requests using exponential backoff per the "Full
Jitter" formula described in
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


## License

The MIT License (MIT)

Copyright (c) 2014 CargoSense, Inc.

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
