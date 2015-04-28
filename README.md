ExAws
=====

A flexible easy to use set of clients AWS APIs.

## Highlighted Features
- Easy configuration.
- Minimal dependencies. Choose your favorite JSON / XML codec and HTTP client.
- Elixir streams to automatically retrieve paginated resources.
- Elixir protocols allow easy customization of Dynamo encoding / decoding.
- `mix kinesis.tail your-stream-name` task for easily grabbing the contents of a kinesis stream.
- Simple. ExAws aims to provide a clear and consistent elixir wrapping around AWS APIs, not abstract them away entirely. For every action in a given AWS API there is a corresponding function within the appropriate module. Higher level abstractions like the aforementioned streams are in addition to and not instead of basic API calls.

## Getting started

Add ex_aws to your mix.exs, along with your json parser and http client of choice. ExAws works out of the box with Poison and HTTPoison and sweet_xml. All APIs require an http client, but only some require a json or xml codec. You only need the codec for the API you intend to use.

- Dynamo: json
- Kinesis: json
- Lambda: json
- S3: xml

See the configuration section for how to specify alternate codecs and clients.

```elixir
def deps do
  [
    ex_aws:    "~> 0.1.0",
    poison:    "~> 1.2.0",
    httpoison: "~> 0.6.0"
  ]
end
```

In your config:

```elixir
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY")
```

That's it! ExAws ships with a default client for each API. Examples:

```elixir
ExAws.Dynamo.list_tables
ExAws.Kinesis.list_streams
ExAws.Lambda.list_functions
ExAws.S3.list_buckets
```

Dynamo usage example:

```elixir
defmodule User do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]
end

alias ExAws.Dynamo

# Create a users table with a primary key of email [String]
# and 1 unit of read and write capacity
Dynamo.create_table("Users", "email", %{email: "S"}, 1, 1)

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
- S3 (in progress)
- Many more planned

## Configuration

To configure the built in clients do the following in your config.exs:

```elixir
config, :ex_aws,
  region: "us-east-2"
  dynamo: [
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
  dynamo: [] # Dynamo config here

config :my_other_app, :ex_aws,
  json_codec: ExAws.JSON.JSX # Maybe :my_other_app uses jsx
  dynamo: [] # Other Dynamo config here
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
  dynamo: [] # Dynamo config here

config :my_other_ex_aws,
  json_codec: ExAws.JSON.JSX # Maybe :my_other_app uses jsx
  dynamo: [] # Other Dynamo config here
```

## Why not erlcloud?

Erlcloud is great, and at present supports a much larger set of APIs than ExAws (although we hope to change that). However, ExAws has a number of distinct advantages over erlcloud in addition to its general features:

- Easier configuration. Erlcloud requires you to pass in the configuration with every request as an optional last parameter. If you forget, it will use the default configuration which may have unintended consequences. With ExAws clients you set the configuration once and then never worry about it again.

- Binaries and Maps. ExAws always uses binaries over char lists, and returns maps instead of proplists from many API endpoints.

- No built in dependencies. Already using Poison? No need to add jsx as a dependency.

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
