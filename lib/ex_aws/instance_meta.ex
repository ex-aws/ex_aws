defmodule ExAws.InstanceMeta do
  @moduledoc false

  # Provides access to the AWS Instance MetaData
  # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html

  # AWS InstanceMetaData URL
  @meta_path_root "http://169.254.169.254/latest/meta-data"

  # Endpoint for ECS tasks role credentials
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
  @task_role_root "http://169.254.170.2"

  alias ExAws.Request

  def request(config, url) do
    do_request(config, url, 1)
  end

  defp do_request(config, url, attempt) do
    case config.http_client.request(:get, url, "", [], []) do
      {:ok, %{status_code: 200, body: body}} ->
        body

      {:ok, %{status_code: 429}} ->
        case Request.attempt_again?(attempt, :rate_limit, config) do
          {:attempt, attempt} ->
            do_request(config, url, attempt)
          {:error, _} ->
            raise_status_error(429)
        end

      {{:ok, %{status_code: status_code}}, _} ->
        raise_status_error(status_code)

      {error, _} ->
        raise """
        Instance Meta Error: #{inspect(error)}

        You tried to access the AWS EC2 instance meta, but it could not be reached.
        This happens most often when trying to access it from your local computer,
        which happens when environment variables are not set correctly prompting
        ExAws to fallback to the Instance Meta.

        Please check your key config and make sure they're configured correctly:

        For Example:
        ```
        ExAws.Config.new(:s3)
        ExAws.Config.new(:dynamodb)
        ```
        """
    end
  end

  defp raise_status_error(status_code) do
    raise """
    Instance Meta Error: HTTP response status code #{inspect(status_code)}

    Please check AWS EC2 IAM role.
    """
  end

  def instance_role(config) do
    ExAws.InstanceMeta.request(config, @meta_path_root <> "/iam/security-credentials/")
  end

  def task_role_credentials(config) do
    case System.get_env("AWS_CONTAINER_CREDENTIALS_RELATIVE_URI") do
      nil ->
        nil

      uri ->
        ExAws.InstanceMeta.request(config, @task_role_root <> uri)
        |> config.json_codec.decode!
    end
  end

  def instance_role_credentials(config) do
    ExAws.InstanceMeta.request(
      config,
      @meta_path_root <> "/iam/security-credentials/#{instance_role(config)}"
    )
    |> config.json_codec.decode!
  end

  def security_credentials(config) do
    result =
      case task_role_credentials(config) do
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
