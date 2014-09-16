defmodule ExAws.Config do
  require Record
  Record.defrecord :aws_config, [
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

  def namespace(data, :dynamo) do
    if table = Keyword.get(data, :TableName) do
      name = [table, Application.get_env(:ex_aws, :ddb_namespace), Mix.env]
        |> Enum.filter(&(&1))
        |> Enum.join("_")
      Keyword.put(data, :TableName, name)
    else
      data
    end
  end

  def namespace(data, :kinesis) do
  end

end
