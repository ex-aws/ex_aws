defmodule ExAws do
  @moduledoc """
  Module for making and processing AWS request
  """

  use Application

  @behaviour ExAws.Behaviour

  @doc """
  Perform an AWS request

  First build an operation from one of the services, and then pass it to this
  function to perform it.

  If you want to build an operation manually, see: `ExAws.Operation`

  This function takes an optional second parameter of configuration overrides.
  This is useful if you want to have certain configuration changed on a per
  request basis.

  ## Examples

  If you have one of the service modules installed, you can just use those service
  modules like this:

      ExAws.S3.list_buckets |> ExAws.request

      ExAws.S3.list_buckets |> ExAws.request(region: "eu-west-1")

      ExAws.Dynamo.get_object("users", "foo@bar.com") |> ExAws.request

  Alternatively you can create operation structs manually for services
  that aren't supported:

      op = %ExAws.Operation.JSON{
        http_method: :post,
        service: :dynamodb,
        headers: [
          {"x-amz-target", "DynamoDB_20120810.ListTables"},
          {"content-type", "application/x-amz-json-1.0"}
        ],
      }

      ExAws.request(op)

  """
  @impl ExAws.Behaviour
  def request(op, config_overrides \\ []) do
    ExAws.Operation.perform(op, ExAws.Config.new(op.service, config_overrides))
  end

  @doc """
  Perform an AWS request, raise if it fails.

  Same as `request/1,2` except it will either return the successful response from
  AWS or raise an exception.
  """
  @impl ExAws.Behaviour
  def request!(op, config_overrides \\ []) do
    case request(op, config_overrides) do
      {:ok, result} ->
        result

      error ->
        raise ExAws.Error, """
        ExAws Request Error!

        #{inspect(error)}
        """
    end
  end

  @doc """
  Return a stream for the AWS resource.

  ## Examples

      ExAws.S3.list_objects("my-bucket") |> ExAws.stream!

  """
  @impl ExAws.Behaviour
  def stream!(op, config_overrides \\ []) do
    ExAws.Operation.stream!(op, ExAws.Config.new(op.service, config_overrides))
  end

  @doc false
  @impl Application
  def start(_type, _args) do
    children = [
      ExAws.Config.AuthCache
    ]

    opts = [strategy: :one_for_one, name: ExAws.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
