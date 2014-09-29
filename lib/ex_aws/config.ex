defmodule ExAws.Config do
  require Record
  @attrs [
    as_host: nil,
    ec2_host: nil,
    iam_host: nil,
    sts_host: nil,
    s3_scheme: nil,
    s3_host: nil,
    s3_port: nil,
    sdb_host: nil,
    elb_host: nil,
    ses_host: nil,
    sqs_host: nil,
    sns_host: nil,
    mturk_host: nil,
    mon_host: nil,
    mon_port: nil,
    mon_protocol: nil,
    ddb_scheme: nil,
    ddb_host: nil,
    ddb_port: nil,
    ddb_retry: nil,
    kinesis_scheme: nil,
    kinesis_host: nil,
    kinesis_port: nil,
    kinesis_retry: nil,
    cloudtrail_scheme: nil,
    cloudtrail_host: nil,
    cloudtrail_port: nil,
    access_key_id: nil,
    secret_access_key: nil,
    security_token: nil,
    timeout: nil,
    cloudtrail_raw_result: nil
  ]
  Record.defrecord :aws_config, @attrs

  def erlcloud_config do
    conf = Application.get_all_env(:ex_aws)
      |> Enum.map(fn
        {k,v} when is_binary(v) -> {k, String.to_char_list(v)}
        x -> x
      end)

    :erlcloud_aws.default_config
      |> aws_config(ddb_scheme: conf[:ddb_scheme])
      |> aws_config(ddb_host: conf[:ddb_host])
      |> aws_config(ddb_port: conf[:ddb_port])
  end


  def config_map(config) do
    @attrs |> Enum.with_index |> Enum.reduce(%{}, fn({{attr, _}, i}, map) ->
      Map.put(map, attr, elem(config, i + 1))
    end)
  end

  ## Dynamo
  #####################

  def namespace(%{TableName: table} = data, :dynamo) do
    Map.put(data, :TableName, namespace(table, :dynamo))
  end
  def namespace(data = %{}, :dynamo), do: data

  def namespace(name, :dynamo) when is_atom(name) or is_binary(name) do
    [name, Application.get_env(:ex_aws, :ddb_namespace) || ""] |> Enum.join
  end

  ## Kinesis
  #####################

  def namespace(%{StreamName: stream} = data, :kinesis) do
    Map.put(data, :StreamName, namespace(stream, :kinesis))
  end
  def namespace(data = %{}, :kinesis), do: data

  def namespace(name, :kinesis) when is_atom(name) or is_binary(name) do
    [name, Application.get_env(:ex_aws, :kinesis_namespace) || ""] |> Enum.join
  end

end
