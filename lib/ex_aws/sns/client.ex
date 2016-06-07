defmodule ExAws.SNS.Client do
  use Behaviour

  @moduledoc """
  Defines an SNS Client

  By default you can use ExAws.SNS

  ## Usage

  ```
  defmodule MyApp.SNS do
    use ExAws.SNS.Client, otp_app: :my_otp_app
  end
  ```

  In your config:

  ```
  config :my_otp_app, :ex_aws,
    sns: [], # SNS config goes here
  ```

  You can now use MyApp.SNS as the root module for the SNS API without
  needing to pass in a particular configuration. This enables different OTP
  apps to configure their AWS configurations separately.

  The alignment with a particular OTP app while convenient is however entirely
  optional.

  The following also works:

  ```
  defmodule MyApp.SNS do
    use ExAws.SNS.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```

  ExAws now expects the config for that client to live under `:my_aws_config_root`:

  ```elixir
  config :my_aws_config_root
    sns: [] # SNS config goes here
  ```

  Default config values can be found in ExAws.Config.

  ## General notes

  TODO

  ## Examples

  TODO

  http://docs.aws.amazon.com/sns/latest/APIReference/API_Operations.html
  """

  ## Endpoints
  ######################

  @type platform_application_arn :: binary
  @type token :: binary

  @doc "Create platform endpoint"
  defcallback create_platform_endpoint(platform_application_arn :: platform_application_arn, token :: token) :: ExAws.Request.response_t

  ## Topics
  ######################

  @type topic_name :: binary
  @type topic_arn  :: binary
  @type topic_attribute_name ::
    :policy |
    :display_name |
    :delivery_policy

  @doc "List topics"
  defcallback list_topics() :: ExAws.Request.response_t
  defcallback list_topics(opts :: [next_token: binary]) :: ExAws.Request.response_t

  @doc "Create topic"
  defcallback create_topic(topic_name :: topic_name) :: ExAws.Request.response_t

  @doc "Get topic attributes"
  defcallback get_topic_attributes(topic_arn :: topic_arn) :: ExAws.Request.response_t

  @doc "Set topic attributes"
  defcallback set_topic_attributes(attribute_name :: topic_attribute_name,
                                   attribute_value :: binary,
                                   topic_arn :: topic_arn) :: ExAws.Request.response_t

  @doc "Delete topic"
  defcallback delete_topic(topic_arn :: topic_arn) :: ExAws.Request.response_t

  ## Publishing
  ######################

  @type message_attribute :: %{
    :name => binary,
    :data_type => :string | :number | :binary,
    :value => {:string, binary} | {:binary, binary}
  }
  @type publish_opts :: [
    {:message_attributes, [message_attribute]} |
    {:message_structure, :json} |
    {:subject, binary} |
    {:target_arn, binary} |
    {:topic_arn, binary}]

  @doc """
  Publish message to a target/topic ARN

  You must set either :target_arn or :topic_arn but not both via the options argument.

  Do NOT assume that because your message is a JSON blob that you should set
  message_structure: to :json. This has a very specific meaning, please see
  http://docs.aws.amazon.com/sns/latest/api/API_Publish.html for details.
  """
  defcallback publish(message :: binary, opts :: publish_opts) :: ExAws.Request.response_t

  ## Requests
  ######################

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the `ExAws.SNS.Request.request/3`.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(client_struct :: %{}, data :: %{}, action :: atom)

  @doc "Retrieves the root AWS config for this client"
  defcallback config_root() :: Keyword.t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :sns

      unquote(boilerplate)

      @doc false
      def request(client, action, data) do
        ExAws.SNS.Request.request(client, action, data)
      end

      defoverridable config_root: 0, request: 3
    end
  end

end
