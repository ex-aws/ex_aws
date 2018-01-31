defmodule ExAws.Config.Defaults do
  @moduledoc """
  Defaults for each service
  """

  @common %{
    access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
    secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
    region: [{:system, "AWS_REGION"}, {:system, "AWS_DEFAULT_REGION"}],
    http_client: ExAws.Request.Hackney,
    json_codec: Poison,
    retries: [
      max_attempts: 10,
      base_backoff_in_ms: 10,
      max_backoff_in_ms: 10_000
    ],
    scheme: "https://",
    port: 443
  }

  @doc """
  Retrieve the default configuration for a service.
  """
  def get(:dynamodb_streams) do
    %{
      service_override: :dynamodb
    } |> Map.merge(get(:dynamodb))
  end

  def get(_service), do: @common
end
