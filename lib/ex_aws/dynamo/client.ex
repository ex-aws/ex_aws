defmodule ExAws.Dynamo.Client do
  use Behaviour
  alias ExAws.Dynamo.Request

  @moduledoc """
  Defines a Dynamo Client

  By default you can use ExAws.Dynamo

  NOTE: When Mix.env in [:test, :dev] dynamo clients will run by default against
  Dynamodb local.

  ## Basic usage
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

  ## Customization
  If you want more than one client you can define your own as follows. If you don't need more
  than one or plan on customizing the request process it's generally easier to just use
  and configure the ExAws.Dynamo client.
  ```
  defmodule MyApp.Dynamo do
    use ExAws.Dynamo.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    dynamodb: [], # Dynamo config goes here
  ```

  You can now use MyApp.Dynamo as the root module for the Dynamo api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app while convenient is however entirely optional.
  The following also works:

  ```
  defmodule MyApp.Dynamo do
    use ExAws.Dynamo.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that dynamo client to live under

  ```elixir
  config :my_aws_config_root
    dynamodb: [] # Dynamo config goes here
  ```

  Default config values can be found in ExAws.Config.

  ## General notes
  All options are handled as underscored atoms instead of camelcased binaries as specified
  in the Dynamo API. IE `IndexName` would be `:index_name`. Anywhere in the API that requires
  dynamo type annotation (`{"S":"mystring"}`) is handled for you automatically. IE

  ```elixir
  ExAws.Dynamo.scan("Users", expression_attribute_values: [api_key: "foo"])
  ```
  Transforms into a query of
  ```elixir
  %{"ExpressionAttributeValues" => %{api_key: %{"S" => "foo"}}, "TableName" => "Users"}
  ```

  Consult the function documentation to see precisely which options are handled this way.

  If you wish to avoid this kind of automatic behaviour you are free to specify the types yourself.
  IE:
  ```elixir
  ExAws.Dynamo.scan("Users", expression_attribute_values: [api_key: %{"B" => "Treated as binary"}])
  ```
  Becomes:
  ```elixir
  %{"ExpressionAttributeValues" => %{api_key: %{"B" => "Treated as binary"}}, "TableName" => "Users"}
  ```
  Alternatively, if what's being encoded is a struct, you're always free to implement ExAws.Dynamo.Encodable for that struct.

  ## Examples

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

  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Operations.html
  """



end
