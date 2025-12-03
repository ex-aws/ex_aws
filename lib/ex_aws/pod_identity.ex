defmodule ExAws.PodIdentity do
  @moduledoc false

  # Provides access to AWS credentials via EKS Pod Identity
  # https://docs.aws.amazon.com/eks/latest/userguide/pod-identities.html

  # Environment variables used by EKS Pod Identity
  @credentials_uri_env "AWS_CONTAINER_CREDENTIALS_FULL_URI"
  @authorization_token_file_env "AWS_CONTAINER_AUTHORIZATION_TOKEN_FILE"

  def available? do
    case {System.get_env(@credentials_uri_env), System.get_env(@authorization_token_file_env)} do
      {uri, token_file} when is_binary(uri) and is_binary(token_file) -> true
      _ -> false
    end
  end

  def security_credentials(config) do
    with {:ok, token} <- read_authorization_token(),
         {:ok, credentials} <- fetch_credentials(config, token) do
      parse_credentials(credentials)
    else
      {:error, reason} ->
        raise """
        Pod Identity Error: #{inspect(reason)}

        You tried to access AWS credentials via EKS Pod Identity, but it failed.
        This happens when the pod is not properly configured with Pod Identity
        or the required environment variables are not set.

        Required environment variables:
        - #{@credentials_uri_env}
        - #{@authorization_token_file_env}

        Please check your EKS Pod Identity configuration.
        """
    end
  end

  defp read_authorization_token do
    case System.get_env(@authorization_token_file_env) do
      nil ->
        {:error, "#{@authorization_token_file_env} environment variable not set"}

      token_file_path ->
        case File.read(token_file_path) do
          {:ok, token} ->
            {:ok, String.trim(token)}

          {:error, reason} ->
            {:error, "Failed to read authorization token from #{token_file_path}: #{reason}"}
        end
    end
  end

  defp fetch_credentials(config, token) do
    case System.get_env(@credentials_uri_env) do
      nil ->
        {:error, "#{@credentials_uri_env} environment variable not set"}

      credentials_uri ->
        headers = [{"Authorization", token}]

        case config.http_client.request(:get, credentials_uri, "", headers, http_opts())
             |> ExAws.Request.maybe_transform_response() do
          {:ok, %{status_code: 200, body: body}} ->
            case config.json_codec.decode(body) do
              {:ok, credentials} -> {:ok, credentials}
              {:error, reason} -> {:error, "Failed to decode credentials JSON: #{reason}"}
            end

          {:ok, %{status_code: status_code, body: body}} ->
            {:error, "HTTP #{status_code}: #{body}"}

          {:error, reason} ->
            {:error, "HTTP request failed: #{reason}"}
        end
    end
  end

  defp parse_credentials(credentials) do
    %{
      access_key_id: credentials["AccessKeyId"],
      secret_access_key: credentials["SecretAccessKey"],
      security_token: credentials["Token"],
      expiration: credentials["Expiration"]
    }
  end

  defp http_opts do
    defaults = [follow_redirect: false, recv_timeout: 5_000]

    overrides =
      Application.get_env(:ex_aws, :pod_identity, [])
      |> Keyword.get(:http_opts, [])

    Keyword.merge(defaults, overrides)
  end
end