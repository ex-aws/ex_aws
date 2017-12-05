defmodule ExAws.Config.Defaults do
  @moduledoc """
  Defaults for each service
  """

  @common %{
    access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
    secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
    http_client: ExAws.Request.Hackney,
    json_codec: Poison,
    retries: [
      max_attempts: 10,
      base_backoff_in_ms: 10,
      max_backoff_in_ms: 10_000
    ],
  }

  @doc """
  Retrieve the default configuration for a service.
  """
  def defaults(:dynamodb_streams) do
    %{
      service_override: :dynamodb
    } |> Map.merge(defaults(:dynamodb))
  end
  def defaults(_) do
    Map.merge(%{
      scheme: "https://",
      region: "us-east-1",
      port: 443
    }, @common)
  end

  def get(service, region) do
    service
    |> defaults
    |> Map.put(:host, host(service, region))
  end

  @partitions [
    {~r/^(us|eu|ap|sa|ca)\-\w+\-\d+$/, "aws"},
    {~r/^cn\-\w+\-\d+$/, "aws-cn"},
    {~r/^us\-gov\-\w+\-\d+$/, "aws-us-gov"}
  ]

  def host(service, region) do
    partition = Enum.find(@partitions, fn {regex, _} ->
      Regex.run(regex, region)
    end)

    with {_, partition} <- partition do
      do_host(partition, service, region)
    end

  end

  defp service_map(:ses), do: "email"
  defp service_map(:dynamodb_streams), do: "streams.dynamodb"
  defp service_map(service) do
    service
    |> to_string
    |> String.replace("_", "-")
  end

  @partition_data :ex_aws
    |> :code.priv_dir()
    |> Path.join("endpoints.exs")
    |> File.read!
    |> Code.eval_string
    |> elem(0)
    |> Map.get("partitions")
    |> Map.new(fn partition ->
      {partition["partition"], partition}
    end)

  def do_host(partition, service_slug, region) do
    partition = @partition_data |> Map.fetch!(partition)
    partition_name = partition["partition"]

    service = service_map(service_slug)

    partition
    |> Map.fetch!("services")
    |> fetch_or(service, "#{service_slug} not found in partition #{partition_name}")
    |> case do
      %{"isRegionalized" => false} = data ->
        data
        |> Map.fetch!("endpoints")
        |> Map.values
        |> List.first
      data ->
        data
        |> Map.fetch!("endpoints")
        |> fetch_or(region, "#{service_slug} not supported in region #{region} for partition #{partition_name}")
    end
    |> case do
      %{"hostname" => hostname} ->
        hostname
      _ ->
        dns_suffix = Map.fetch!(partition, "dnsSuffix")
        hostname = Map.fetch!(partition, "defaults") |> Map.fetch!("hostname")
        apply_defaults(hostname, service, region, dns_suffix)
    end
  end

  defp fetch_or(map, key, msg) do
    Map.get(map, key) || raise msg
  end

  def apply_defaults(hostname, service, region, dns_suffix) do
    hostname
    |> String.replace("{service}", service)
    |> String.replace("{region}", region)
    |> String.replace("{dnsSuffix}", dns_suffix)
  end

end
