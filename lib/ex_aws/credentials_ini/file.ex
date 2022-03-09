if Code.ensure_loaded?(ConfigParser) do
  defmodule ExAws.CredentialsIni.File do
    @moduledoc false

    import ExAws.Request.Hackney, only: [request: 4]
    # as per https://docs.aws.amazon.com/cli/latest/topic/config-vars.html
    @valid_config_keys ~w(
      aws_access_key_id aws_secret_access_key aws_session_token region
      role_arn source_profile credential_source external_id mfa_serial role_session_name credential_process
      sso_start_url sso_region sso_account_id sso_role_name
    )

    def security_credentials(profile_name) do
      shared_credentials = profile_from_shared_credentials(profile_name)
      config_credentials = profile_from_config(profile_name)
      merge_credentials(config_credentials, shared_credentials)
    end

    defp merge_credentials(
           %{
             sso_start_url: sso_start_url,
             sso_account_id: sso_account_id,
             sso_role_name: sso_role_name,
           } = config_credentials,
           _shared_credentials
         ) do
           case get_sso_role_credentials(sso_start_url, sso_account_id, sso_role_name) do
             {:ok, sso_creds} -> {:ok, Map.merge(sso_creds, config_credentials)}
             {:error, _} = err -> err
           end
    end

    defp merge_credentials(config_credentials, shared_credentials) do
      Map.merge(config_credentials, shared_credentials)
    end

    defp get_sso_cache_file(sso_start_url) do
      hash = :crypto.hash(:sha, sso_start_url) |> Base.encode16() |> String.downcase()

      System.user_home()
      |> Path.join(".aws/sso/cache/#{hash}.json")
    end

    defp get_sso_role_credentials(sso_start_url, sso_account_id, sso_role_name) do
      sso_start_url
      |> get_sso_cache_file()
      |> File.read()
      |> parse_sso_cache_file
      |> check_sso_expiration
      |> request_sso_role_credentials(sso_account_id, sso_role_name)
      |> rename_sso_credential_keys
    end

    defp parse_sso_cache_file({:ok, contents}) do
      contents
      |> Jason.decode()
    end

    defp parse_sso_cache_file(err), do: err

    defp check_sso_expiration({:ok, %{"expiresAt" => expires_at_str} = config}) do
      with {:ok, expires_at, _} <- DateTime.from_iso8601(expires_at_str)
      do
        case DateTime.compare(expires_at, DateTime.utc_now()) do
          :gt -> {:ok, config}
          _ -> {:error, "SSO access token is expired, refresh the token with `aws sso login`"}
        end
      else
        {:error, err} -> {:error, "SSO cache file has invalid expiration format: #{err}"}
      end
    end

    defp check_sso_expiration(err), do: err

    #TODO: Implement check that verifies if a user has aws_sso and source profile configured
    # Saw this concern raised in saml2aws using aws go sdk and think it could be helpful

    # TODO: the :ex_aws.request() abstraction that can choose hackney or what users set requires signing
    # We can't sign yet, so this is written to hackney, but need to revisit alternatives
    defp request_sso_role_credentials({:ok, %{"accessToken" => access_token, "region" => region}}, account_id, role_name) do
      with {:ok, %{status_code: 200, headers: _headers, body: body}} <-
             request(
               :get,
               "https://portal.sso.#{region}.amazonaws.com/federation/credentials?account_id=#{account_id}&role_name=#{role_name}",
               "",
               [{"x-amz-sso_bearer_token", access_token}]
             ) do

        body
        |> Jason.decode()
      else
        error -> error
      end
    end

    defp request_sso_role_credentials(err, _, _), do: err

    defp rename_sso_credential_keys({:ok, %{"roleCredentials" => role_credentials}}) do
      {:ok, Enum.reduce(role_credentials, %{}, fn
        {"accessKeyId", v}, acc -> Map.put(acc, :access_key_id, v)
        {"expiration", v}, acc -> Map.put(acc, :expiration, v)
        {"secretAccessKey", v}, acc -> Map.put(acc, :secret_access_key, v)
        {"sessionToken", v}, acc -> Map.put(acc, :security_token, v)
      end)
      }
    end

    defp rename_sso_credential_keys(err), do: err

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
      section =
        case profile_name do
          :system -> "profile #{profile_name_from_env()}"
          "default" -> "default"
          other -> "profile #{other}"
        end

      System.user_home()
      |> Path.join(".aws/config")
      |> File.read()
      |> parse_ini_file(section)
    end

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
