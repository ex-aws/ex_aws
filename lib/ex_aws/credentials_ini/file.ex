if Code.ensure_loaded?(ConfigParser) do
  defmodule ExAws.CredentialsIni.File do
    @moduledoc false

    # as per https://docs.aws.amazon.com/cli/latest/topic/config-vars.html
    @valid_config_keys ~w(
      aws_access_key_id aws_secret_access_key aws_session_token region
      role_arn source_profile credential_source external_id mfa_serial role_session_name credential_process
      sso_start_url sso_region sso_account_id sso_role_name
    )

    def security_credentials(profile_name) do
      config_credentials = profile_from_config(profile_name)
      shared_credentials = profile_from_shared_credentials(profile_name)

      case config_credentials do
        %{
          sso_start_url: sso_start_url,
          sso_account_id: sso_account_id,
          sso_role_name: sso_role_name
        } ->
          config = ExAws.Config.http_config(:sso)

          case get_sso_role_credentials(sso_start_url, sso_account_id, sso_role_name, config) do
            {:ok, sso_creds} -> {:ok, Map.merge(sso_creds, shared_credentials)}
            {:error, _} = err -> err
          end

        %{credential_process: credential_process} ->
          config = ExAws.Config.http_config(:sso)

          case get_credentials_from_process(credential_process, config) do
            {:ok, credentials} -> {:ok, Map.merge(credentials, shared_credentials)}
            {:error, _} = err -> err
          end

        _ ->
          {:ok, Map.merge(config_credentials, shared_credentials)}
      end
    end

    defp get_sso_role_credentials(sso_start_url, sso_account_id, sso_role_name, config) do
      with {_, {:ok, sso_cache_content}} <-
             {:read, File.read(get_sso_cache_file(sso_start_url))},
           {_,
            {:ok, %{"expiresAt" => expires_at, "accessToken" => access_token, "region" => region}}} <-
             {:decode, config[:json_codec].decode(sso_cache_content)},
           {_, :ok} <-
             {:expiration, check_sso_expiration(expires_at)},
           {_, {:ok, sso_creds}} <-
             {:sso_creds,
              request_sso_role_credentials(
                access_token,
                region,
                sso_account_id,
                sso_role_name,
                config
              )},
           {_, {:ok, reformatted_creds}} <-
             {:rename, rename_sso_credential_keys(sso_creds)} do
        {:ok, reformatted_creds}
      else
        {:read, {:error, error}} -> {:error, "Could not read SSO cache file: #{error}"}
        {:decode, _} -> {:error, "SSO cache file contains invalid json"}
        {:expiration, error} -> error
        {:sso_creds, error} -> error
        {:rename, error} -> error
      end
    end

    defp get_sso_cache_file(sso_start_url) do
      hash = :crypto.hash(:sha, sso_start_url) |> Base.encode16() |> String.downcase()

      System.user_home()
      |> Path.join(".aws/sso/cache/#{hash}.json")
    end

    defp check_sso_expiration(expires_at_str) do
      with {:ok, _} <- check_expiration(expires_at_str) do
        :ok
      else
        {:timestamp, {:error, err}} ->
          {:error, "SSO cache file has invalid expiration format: #{err}"}

        {:expires, _} ->
          {:error, "SSO access token is expired, refresh the token with `aws sso login`"}
      end
    end

    defp request_sso_role_credentials(
           access_token,
           region,
           account_id,
           role_name,
           config
         ) do
      with {_, {:ok, %{status_code: 200, headers: _headers, body: body_raw}}} <-
             {:request,
              config[:http_client].request(
                :get,
                "https://portal.sso.#{region}.amazonaws.com/federation/credentials?account_id=#{account_id}&role_name=#{role_name}",
                "",
                [{"x-amz-sso_bearer_token", access_token}],
                Map.get(config, :http_opts, [])
              )},
           {_, {:ok, body}} <- {:decode, config[:json_codec].decode(body_raw)} do
        {:ok, body}
      else
        {:request, {_, %{status_code: status_code} = resp}} ->
          {:error, "SSO role credentials request responded with #{status_code}: #{resp}"}

        {:decode, err} ->
          {:error, "Could not decode SSO role credentials response: #{err}"}
      end
    end

    defp rename_sso_credential_keys(%{"roleCredentials" => role_credentials}) do
      with {_, access_key} when not is_nil(access_key) <-
             {:accessKey, Map.get(role_credentials, "accessKeyId")},
           {_, expiration} when not is_nil(expiration) <-
             {:expiration, Map.get(role_credentials, "expiration")},
           {_, secret_access_key} when not is_nil(secret_access_key) <-
             {:secretAccess, Map.get(role_credentials, "secretAccessKey")},
           {_, session_token} when not is_nil(session_token) <-
             {:sessionToken, Map.get(role_credentials, "sessionToken")} do
        {:ok,
         %{
           access_key_id: access_key,
           expiration: expiration,
           secret_access_key: secret_access_key,
           security_token: session_token
         }}
      else
        {missing, _} -> {:error, "#{missing} is missing from SSO role credential response"}
      end
    end

    defp get_credentials_from_process(credential_process, config) do
      with {_, {:ok, process_result}} <-
             {:process, execute_process(credential_process)},
           {_, {:ok, %{"Version" => 1} = result}} <-
             {:decode, config[:json_codec].decode(process_result)},
           {_, {:ok, expiration}} <-
             {:expiration, check_credentials_expiration(result)},
           {_, {:ok, reformatted_creds}} <-
             {:rename, format_result(result, expiration)} do
        {:ok, reformatted_creds}
      else
        {:process, {:error, error}} -> {:error, "Could not execute process: #{error}"}
        {:decode, _} -> {:error, "Credentials process results contains invalid json"}
        {:expiration, error} -> error
        {:rename, error} -> error
      end
    end

    defp execute_process(credential_process) do
      with [command | args] <- String.split(credential_process),
           {result, 0} <- System.cmd(command, args, stderr_to_stdout: true) do
        {:ok, result}
      else
        [] -> {:error, "Could not read command from config file : #{credential_process}"}
        {error, exit_code} -> {:error, "Exit code : #{exit_code} - #{error}"}
      end
    end

    defp format_result(result, nil) do
      with {_, access_key} when not is_nil(access_key) <-
             {:accessKey, Map.get(result, "AccessKeyId")},
           {_, secret_access_key} when not is_nil(secret_access_key) <-
             {:secretAccess, Map.get(result, "SecretAccessKey")} do
        {:ok,
         %{
           access_key_id: access_key,
           secret_access_key: secret_access_key
         }}
      else
        {missing, _} -> {:error, "#{missing} is missing from credentials process response"}
      end
    end

    defp format_result(result, expiration) do
      with {_, access_key} when not is_nil(access_key) <-
             {:accessKey, Map.get(result, "AccessKeyId")},
           {_, secret_access_key} when not is_nil(secret_access_key) <-
             {:secretAccess, Map.get(result, "SecretAccessKey")},
           {_, session_token} when not is_nil(session_token) <-
             {:sessionToken, Map.get(result, "SessionToken")} do
        {:ok,
         %{
           access_key_id: access_key,
           expiration: DateTime.to_unix(expiration),
           secret_access_key: secret_access_key,
           security_token: session_token
         }}
      else
        {missing, _} -> {:error, "#{missing} is missing from credentials process response"}
      end
    end

    defp check_credentials_expiration(%{"Expiration" => expiration_str}) do
      with {:ok, expiration} <- check_expiration(expiration_str) do
        {:ok, expiration}
      else
        {:timestamp, {:error, err}} ->
          {:error, "Process returned invalid expiration format: #{err}"}

        {:expires, _} ->
          {:error, "Process returned expired credentials"}
      end
    end

    defp check_credentials_expiration(_), do: {:ok, nil}

    defp check_expiration(expiration_str) do
      with {_, {:ok, expiration, _}} <- {:timestamp, DateTime.from_iso8601(expiration_str)},
           {_, :gt} <- {:expires, DateTime.compare(expiration, DateTime.utc_now())} do
        {:ok, expiration}
      end
    end

    def parse_ini_file({:ok, contents}, :system) do
      parse_ini_file({:ok, contents}, profile_name_from_env())
    end

    def parse_ini_file({:ok, contents}, profile_name) do
      contents
      |> ConfigParser.parse_string()
      |> case do
        {:ok, %{^profile_name => config}} ->
          strip_key_prefix(config)

        {:ok, %{}} ->
          %{}

        _ ->
          %{}
      end
    end

    def parse_ini_file(_, _), do: %{}

    def strip_key_prefix(credentials) do
      credentials
      |> Map.take(@valid_config_keys)
      |> Map.new(fn {key, val} ->
        updated_key =
          key
          |> String.replace_leading("aws_", "")
          |> String.to_atom()

        {updated_key, val}
      end)
    end

    def replace_token_key(credentials) do
      case Map.pop(credentials, :session_token) do
        {nil, credentials} ->
          credentials

        {token, credentials} ->
          Map.put(credentials, :security_token, token)
      end
    end

    defp profile_from_shared_credentials(profile_name) do
      System.user_home()
      |> Path.join(".aws/credentials")
      |> File.read()
      |> parse_ini_file(profile_name)
      |> replace_token_key
    end

    defp profile_from_config(profile_name) do
      section = profile_from_name(profile_name)

      System.user_home()
      |> Path.join(".aws/config")
      |> File.read()
      |> parse_ini_file(section)
    end

    defp profile_from_name(:system) do
      profile_name_from_env()
      |> profile_from_name()
    end

    defp profile_from_name("default"), do: "default"
    defp profile_from_name(other), do: "profile #{other}"

    defp profile_name_from_env() do
      System.get_env("AWS_PROFILE") || "default"
    end
  end
else
  defmodule ExAws.CredentialsIni.File do
    @moduledoc false

    def security_credentials(_), do: raise("ConfigParser required to use")
    def parse_ini_file(_, _), do: raise("ConfigParser required to use")
    def replace_token_key(_), do: raise("ConfigParser required to use")
  end
end
