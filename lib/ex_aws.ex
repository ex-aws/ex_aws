defmodule ExAws do
  @moduledoc File.read!("#{__DIR__}/../README.md")
  use Application

  @doc """
  Perform an AWS request

  First build an operation from one of the services, and then pass it to this
  function to perform it.

  This function takes an optional second parameter of configuration overrides.
  This is useful if you want to have certain configuration changed on a per
  request basis.

  ## Examples

  ```
  ExAws.S3.list_buckets |> ExAws.request

  ExAws.S3.list_buckets |> ExAws.request(region: "eu-west-1")

  ExAws.Dynamo.get_object("users", "foo@bar.com") |> ExAws.request
  ```

  """
  @spec request(ExAws.Operation.t) :: term
  @spec request(ExAws.Operation.t, Keyword.t) :: {:ok, term} | {:error, term}
  def request(op, config_overrides \\ []) do
    ExAws.Operation.perform(op, ExAws.Config.new(op.service, config_overrides))
  end

  @doc """
  Perform an AWS request, raise if it fails.

  Same as `request/1,2` except it will either return the successful response from
  AWS or raise an exception.
  """
  @spec request!(ExAws.Operation.t) :: term | no_return
  @spec request!(ExAws.Operation.t, Keyword.t) :: term | no_return
  def request!(op, config_overrides \\ []) do
    case request(op, config_overrides) do
      {:ok, result} ->
        result

      error ->
        raise ExAws.Error, """
          ExAws Request Error!

          #{inspect error}
          """
    end
  end

  @doc """
  Return a stream for the AWS resource.

  ## Examples
  ```
  ExAws.S3.list_objects("my-bucket") |> ExAws.stream!
  ```
  """
  @spec stream!(ExAws.Operation.t) :: Enumerable.t
  @spec stream!(ExAws.Operation.t, Keyword.t) :: Enumerable.t
  def stream!(op, config_overrides \\ []) do
    ExAws.Operation.stream!(op, ExAws.Config.new(op.service, config_overrides))
  end

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ExAws.Config.AuthCache, [[name: ExAws.Config.AuthCache]]),
      worker(ExAws.SNS.PublicKeyCache, [[name: ExAws.SNS.PublicKeyCache]])
    ]

    opts = [strategy: :one_for_one, name: ExAws.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
