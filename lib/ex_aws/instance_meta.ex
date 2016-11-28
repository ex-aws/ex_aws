defmodule ExAws.InstanceMeta do

  @moduledoc false

  # Provides access to the AWS Instance MetaData
  # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html

  # AWS InstanceMetaData URL
  @meta_path_root "http://169.254.169.254/latest/meta-data/"

  # Endpoint for ECS taks role credentials
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
  @task_role_root "http://169.254.170.2"

  def request(config, url) do
    case config.http_client.request(:get, url) do
      {:ok, %{body: body}} -> body
    end
  end

  def instance_role(config) do
    ExAws.InstanceMeta.request(config, "/iam/security-credentials/")
  end

  def task_role_credentials(config) do
    case System.get_env("AWS_CONTAINER_CREDENTIALS_RELATIVE_URI") do
      nil -> nil
      uri -> ExAws.InstanceMeta.request(config, @task_role_root <> uri)
             |> config.json_codec.decode!
    end
  end

  def instance_role_credentials(config) do
    ExAws.InstanceMeta.request(config, @meta_path_root <> "/iam/security-credentials/#{instance_role(config)}")
    |> config.json_codec.decode!
  end

  def security_credentials(config) do
    result = case task_role_credentials(config) do
	       nil -> instance_role_credentials(config)
	       credentials -> credentials
	     end

    %{
      access_key_id: result["AccessKeyId"],
      secret_access_key: result["SecretAccessKey"],
      security_token: result["Token"],
      expiration: result["Expiration"]
    }
  end
end
