if Code.ensure_loaded?(ConfigParser) do
  defmodule ExAws.CredentialsIni.File do
    @moduledoc false

    # as per https://docs.aws.amazon.com/cli/latest/topic/config-vars.html
    @valid_config_keys ~w(
      aws_access_key_id aws_secret_access_key aws_session_token region
      role_arn source_profile credential_source external_id mfa_serial role_session_name credential_process
      sso_start_url sso_region sso_account_id sso_role_name sso_session
    )

    @special_merge_keys ~w(sso_session)

    def security_credentials(profile_name) do
      config_credentials = profile_from_config(profile_name)
      shared_credentials = profile_from_shared_credentials(profile_name)

      case config_credentials do
        %{
          sso_start_url: sso_start_url,
          sso_account_id: sso_account_id,
          sso_role_name: sso_role_name
        } ->
          sso_cache_key = Map.get(config_credentials, :sso_session, sso_start_url)
          config = ExAws.Config.http_config(:sso)

          case get_sso_role_credentials(sso_cache_key, sso_account_id, sso_role_name, config) do
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

    defp get_sso_role_credentials(sso_cache_key, sso_account_id, sso_role_name, config) do
      with {_, {:ok, sso_cache_content}} <-
             {:read, File.read(get_sso_cache_file(sso_cache_key))},
           {_, {:ok, %{"expiresAt" => expires_at, "accessToken" => _, "region" => _} = sso_cache}} <-
             {:decode, config[:json_codec].decode(sso_cache_content)},
           {_, :ok, _sso_cache} <-
             {:expiration, check_sso_expiration(expires_at), sso_cache},
           {_, {:ok, sso_creds}} <-
             {:sso_creds,
              request_sso_role_credentials(
                sso_cache_key,
                sso_cache,
                sso_account_id,
                sso_role_name,
                config
              )},
           {_, {:ok, reformatted_creds}} <-
             {:rename, rename_sso_credential_keys(sso_creds)} do
        {:ok, reformatted_creds}
      else
        {:read, {:error, error}} ->
          {:error, "Could not read SSO cache file: #{error}"}

        {:decode, _} ->
          {:error, "SSO cache file contains invalid json"}

        {:expiration, {:error, :expired_token}, sso_cache} ->
          case get_sso_cache_with_refresh(
                 sso_cache,
                 sso_cache_key,
                 sso_account_id,
                 sso_role_name,
                 config
               ) do
            {:ok, sso_creds} ->
              case rename_sso_credential_keys(sso_creds) do
                {:ok, reformatted_creds} -> {:ok, reformatted_creds}
                {:error, error} -> {:error, error}
              end

            {:error, error} ->
              {:error, error}
          end

        {:expiration, error, _sso_cache} ->
          error

        {:sso_creds, error} ->
          error

        {:rename, error} ->
          error
      end
    end

    defp get_sso_cache_file(sso_cache_key) do
      hash = :crypto.hash(:sha, sso_cache_key) |> Base.encode16() |> String.downcase()

      System.user_home()
      |> Path.join(".aws/sso/cache/#{hash}.json")
    end

    defp get_sso_cache_with_refresh(
           sso_cache,
           sso_cache_key,
           sso_account_id,
           sso_role_name,
           config
         ) do
      with {_, {:ok, new_access_token}} <-
             {:refresh, refresh_access_token(sso_cache, sso_cache_key, config)},
           {_, {:ok, sso_creds}} <-
             {:sso_creds,
              make_sso_request(
                new_access_token,
                sso_cache["region"],
                sso_account_id,
                sso_role_name,
                config
              )} do
        {:ok, sso_creds}
      else
        {:refresh, {:error, error}} -> {:error, "Failed to refresh access token: #{error}"}
        {:sso_creds, error} -> error
      end
    end

    defp check_sso_expiration(expires_at_str) do
      with {:ok, _} <- check_expiration(expires_at_str) do
        :ok
      else
        {:timestamp, {:error, err}} ->
          {:error, "SSO cache file has invalid expiration format: #{err}"}

        {:expires, _} ->
          {:error, :expired_token}
      end
    end

    # Overloaded version to handle the case where we don't have the key easily or just want to fail?
    # Actually, let's fix the call site in `get_sso_role_credentials` above to pass sso_cache_key.
    # And update `request_sso_role_credentials` definition below.

    defp request_sso_role_credentials(
           sso_cache_key,
           sso_cache,
           account_id,
           role_name,
           config
         ) do
      %{
        "region" => region
      } = sso_cache

      access_token = sso_cache["accessToken"]

      case make_sso_request(access_token, region, account_id, role_name, config) do
        {:ok, result} ->
          {:ok, result}

        {:error, :expired_token} ->
          case refresh_access_token(sso_cache, sso_cache_key, config) do
            {:ok, new_access_token} ->
              make_sso_request(new_access_token, region, account_id, role_name, config)

            {:error, refresh_error} ->
              {:error, "Failed to refresh access token: #{refresh_error}"}
          end

        {:error, other_error} ->
          {:error, other_error}
      end
    end

    defp make_sso_request(access_token, region, account_id, role_name, config) do
      http_opts = Map.get(config, :http_opts, [])
      # Disable pooling for auth requests to avoid starvation
      http_opts = Keyword.merge(http_opts, pool: false)

      with {_, {:ok, %{status_code: 200, headers: _headers, body: body_raw}}} <-
             {:request,
              config[:http_client].request(
                :get,
                "https://portal.sso.#{region}.amazonaws.com/federation/credentials?account_id=#{account_id}&role_name=#{role_name}",
                "",
                [{"x-amz-sso_bearer_token", access_token}],
                http_opts
              )
              |> ExAws.Request.maybe_transform_response()},
           {_, {:ok, body}} <- {:decode, config[:json_codec].decode(body_raw)} do
        {:ok, body}
      else
        {:request, {_, %{body: body, status_code: 401}} = resp} ->
          case config[:json_codec].decode(body) do
            {:ok, %{"message" => "Session token not found or invalid"}} ->
              {:error, :expired_token}

            _ ->
              {:error, "SSO role credentials request responded with 401: #{inspect(resp)}"}
          end

        {:request, {_, %{status_code: status_code} = resp}} ->
          {:error, "SSO role credentials request responded with #{status_code}: #{inspect(resp)}"}

        {:request, {:error, reason}} ->
          {:error, "SSO role credentials request failed: #{inspect(reason)}"}

        {:decode, err} ->
          {:error, "Could not decode SSO role credentials response: #{err}"}

        error ->
          error
      end
    end

    defp refresh_access_token(sso_cache, sso_cache_key, config) do
      body_map = %{
        "grantType" => "refresh_token",
        "clientId" => sso_cache["clientId"],
        "clientSecret" => sso_cache["clientSecret"],
        "refreshToken" => sso_cache["refreshToken"]
      }

      headers = [
        {"Content-Type", "application/json"}
      ]

      body = config[:json_codec].encode!(body_map)
      region = sso_cache["region"]

      http_opts = Map.get(config, :http_opts, [])
      # Disable pooling for auth requests to avoid starvation
      http_opts = Keyword.merge(http_opts, pool: false)

      with {:ok, %{status_code: 200, body: body_raw}} <-
             config[:http_client].request(
               :post,
               "https://oidc.#{region}.amazonaws.com/token",
               body,
               headers,
               http_opts
             )
             |> ExAws.Request.maybe_transform_response(),
           {:ok, %{"accessToken" => new_access_token} = token_response} <-
             config[:json_codec].decode(body_raw) do
        # Write back to cache
        update_sso_cache_file(sso_cache_key, sso_cache, token_response, config)

        {:ok, new_access_token}
      else
        {:error, _} = error ->
          error

        {_, %{status_code: status_code, body: body}} ->
          {:error, "Token refresh failed with status #{status_code}: #{body}"}

        {_, _} ->
          {:error, "Failed to parse refresh token response"}
      end
    end

    defp update_sso_cache_file(sso_cache_key, old_cache, token_response, config) do
      expires_in = Map.get(token_response, "expiresIn", 0)

      # Use DateTime to calculate new expiration
      # UTC ISO 8601 format: 2023-10-26T12:00:00Z
      new_expires_at =
        DateTime.utc_now()
        |> DateTime.add(expires_in, :second)
        # Remove microseconds to be cleaner/closer to AWS format
        |> DateTime.truncate(:second)
        |> DateTime.to_iso8601()
        # Ensure Z suffix if not present
        |> (fn s -> if String.ends_with?(s, "Z"), do: s, else: s <> "Z" end).()

      updated_cache =
        old_cache
        |> Map.put("accessToken", token_response["accessToken"])
        |> Map.put("expiresAt", new_expires_at)

      updated_cache =
        if token_response["refreshToken"] do
          Map.put(updated_cache, "refreshToken", token_response["refreshToken"])
        else
          updated_cache
        end

      file_path = get_sso_cache_file(sso_cache_key)

      json = config[:json_codec].encode!(updated_cache)

      case File.write(file_path, json) do
        :ok ->
          :ok

        {:error, reason} ->
          require Logger
          Logger.warning("Failed to write SSO cache file: #{inspect(reason)}")
      end
    end

    def rename_sso_credential_keys(%{"roleCredentials" => role_credentials}) do
      with {_, access_key} when not is_nil(access_key) <-
             {:accessKey, Map.get(role_credentials, "accessKeyId")},
           {_, expiration} when not is_nil(expiration) <-
             {:expiration, Map.get(role_credentials, "expiration")},
           {_, secret_access_key} when not is_nil(secret_access_key) <-
             {:secretAccess, Map.get(role_credentials, "secretAccessKey")},
           {_, session_token} when not is_nil(session_token) <-
             {:sessionToken, Map.get(role_credentials, "sessionToken")} do
        # AWS SSO returns expiration as an integer in milliseconds,
        # but ex_aws auth cache expects it in seconds.
        expiration_sec =
          if is_integer(expiration) and expiration > 99_999_999_999 do
            div(expiration, 1000)
          else
            expiration
          end

        {:ok,
         %{
           access_key_id: access_key,
           expiration: expiration_sec,
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
      composite_key = "profile " <> profile_name

      contents
      |> ConfigParser.parse_string()
      |> case do
        {:ok, %{^profile_name => config} = full} ->
          merge_special_keys(full, config)
          |> strip_key_prefix()

        {:ok, %{^composite_key => config} = full} ->
          merge_special_keys(full, config)
          |> strip_key_prefix()

        {:ok, %{}} ->
          %{}

        _ ->
          %{}
      end
    end

    def parse_ini_file(_, _), do: %{}

    def merge_special_keys(full_config, credentials) do
      credentials
      |> Map.take(@special_merge_keys)
      |> Enum.reduce(credentials, fn {key, val}, acc ->
        merge_section = "#{String.replace(key, "_", "-")} #{val}"

        case full_config do
          %{^merge_section => config} ->
            Map.merge(config, acc)

          _ ->
            acc
        end
      end)
    end

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
