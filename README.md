ExAws
=====
[![Build Status](https://travis-ci.org/CargoSense/ex_aws.svg?branch=master)](https://travis-ci.org/CargoSense/ex_aws)

A flexible easy to use set of clients AWS APIs.

## Highlighted Features
- Easy configuration.
- Minimal dependencies. Choose your favorite JSON codec and HTTP client.
- Elixir streams to automatically retrieve paginated resources.
- Elixir protocols allow easy customization of Dynamo encoding / decoding.
- `mix kinesis.tail your-stream-name` task for easily watching the contents of a kinesis stream.
- Simple. ExAws aims to provide a clear and consistent elixir wrapping around AWS APIs, not abstract them away entirely. For every action in a given AWS API there is a corresponding function within the appropriate module. Higher level abstractions like the aforementioned streams are in addition to and not instead of basic API calls.
- Erlang user? Easily configure erlang friendly module names like `ex_aws_s3` instead of `'Elixir.ExAws.S3'`

## Getting started

Add ex_aws to your mix.exs, along with your json parser and http client of choice. ExAws works out of the box with Poison and HTTPoison and sweet_xml. All APIs require an http client, but only some require a json or xml codec. You only need the codec for the API you intend to use. At this time only SweetXml is supported for xml parsing.

- Dynamo: json
- Kinesis: json
- Lambda: json
- SQS: xml
- S3: xml

If you wish to use instance roles to obtain AWS access keys you will need to add a JSON codec whether the particular API requires one or not.

```elixir
def deps do
  [
    ex_aws:    "~> 0.4.10",
    poison:    "~> 1.2",
    httpoison: "~> 0.7"
  ]
end
```
Don't forget to add :httpoison to your applications list if that's in fact the http client you choose. `:ex_aws` must always be added to your applications list.

```elixir
def application do
  [applications: [:ex_aws, :httpoison]]
end
```

That's it!

ExAws has by default the equivalent including the following in your mix.exs

```elixir
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
```

This means it will first look for the AWS standard `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables, and fall back using instance meta-data if those don't exist. You should set those environment variables to your credentials, or configure an instance that this library runs on to have an iam role.

## Usage

ExAws ships with a default client for each API:
`[ExAws.Dynamo, ExAws.Kinesis, ExAws.Lambda, ExAws.S3]`

For particular usage instructions, please consult the client definition for your desired service.
- [ExAws.Dynamo.Client](http://hexdocs.pm/ex_aws/ExAws.Dynamo.Client.html)
- [ExAws.Kinesis.Client](http://hexdocs.pm/ex_aws/ExAws.Kinesis.Client.html)
- [ExAws.Lambda.Client](http://hexdocs.pm/ex_aws/ExAws.Lambda.Client.html)
- [ExAws.S3.Client](http://hexdocs.pm/ex_aws/ExAws.S3.Client.html)

Dynamo usage example:

```elixir
defmodule User do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]
end

alias ExAws.Dynamo

# Create a users table with a primary key of email [String]
# and 1 unit of read and write capacity
Dynamo.create_table("Users", "email", %{email: :string}, 1, 1)

user = %User{email: "bubba@foo.com", name: "Bubba", age: 23, admin: false}
# Save the user
Dynamo.put_item("Users", user)

# Retrieve the user by email and decode it as a User struct.
result = Dynamo.get_item!("Users", %{email: user.email})
|> Dynamo.Decoder.decode(as: User)

assert user == result
```

Consult the relevant documentation for the API of interest.

## Supported APIs
- Dynamo
- Kinesis
- Lambda
- SQS
- S3 (in progress)
- Many more planned

## Configuration

To configure the built in clients do the following in your config.exs:

```elixir
config :ex_aws,
  region: "us-east-2",
  dynamodb: [
    region: "us-west-1"
  ]
```

Top level configuration options (those directly beneath ``:ex_aws`) will automatically apply to all clients, although a given client can override the default. So for example in the above configuration the first `region: "us-east-2"` sets the region for dynamo, kinesis, s3 etc to "us-east-2", but then the particular configuration for dynamo overrides that to "us-west-1".

The following top level configuration options are supported:
`[:http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests]`

## Client configuration

ExAws easily supports more than one client for a given service. To create your own associated with a particular OTP app:

```elixir
defmodule MyApp.Dynamo do
  use ExAws.Dynamo.Client, otp_app: :my_app
end

defmodule MyOtherApp.Dynamo do
  use ExAws.Dynamo.Client, otp_app: :my_other_app
end
```

To configure:
```elixir
config :my_app, :ex_aws,
  dynamodb: [] # Dynamo config here

config :my_other_app, :ex_aws,
  json_codec: ExAws.JSON.JSX # Maybe :my_other_app uses jsx
  dynamodb: [] # Other Dynamo config here
```

The association with a particular OTP app is merely for convenience, and is entirely optional. To configure multiple clients without reference to another app simply write your own `config_root/0` in each client to tell ExAws where to find the configuration.

```elixir
defmodule My.Dynamo do
  use ExAws.Dynamo.Client

  def config_root do
    Application.get_all_env(:my_ex_aws)
  end
end

defmodule MyOther.Dynamo do
  use ExAws.Dynamo.Client

  def config_root do
    Application.get_all_env(:my_other_ex_aws)
  end
end
```

To configure:

```elixir
config :my_ex_aws,
  dynamodb: [] # Dynamo config here

config :my_other_ex_aws,
  json_codec: ExAws.JSON.JSX # Maybe :my_other_app uses jsx
  dynamodb: [] # Other Dynamo config here
```

## ExAws vs. Erlcloud

In addition to its unique features, ExAws has a number of advantages over erlcloud in particular:

- Easier configuration. ExAws uses your normal mix config, erlcloud requires you to separately generate a configuration record.

- Guaranteed configuration. Erlcloud requires you to pass in the configuration with every request as an optional last parameter. If you forget, it will use the default configuration which may have unintended consequences. With ExAws clients you set the configuration once and then never worry about it again.

- Binaries and Maps. ExAws always uses binaries over char lists, and returns maps instead of proplists.

- Few built in dependencies. Already using Poison? No need to add jsx as a dependency.

- Lambda support

It's worth noting however that erlcloud supports a substantially larger set of AWS services at this time.

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
