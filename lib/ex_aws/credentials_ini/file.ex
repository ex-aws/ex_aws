if Code.ensure_loaded?(ConfigParser) do
  defmodule ExAws.CredentialsIni.File do
    # as per https://docs.aws.amazon.com/cli/latest/topic/config-vars.html
    @valid_config_keys ~w(
      aws_access_key_id aws_secret_access_key aws_session_token region
      role_arn source_profile credential_source external_id mfa_serial role_session_name credential_process
    )

    def security_credentials(profile_name) do
      shared_credentials = profile_from_shared_credentials(profile_name)
      config_credentials = profile_from_config(profile_name)
      Map.merge(config_credentials, shared_credentials)
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
    def security_credentials(_), do: raise("ConfigParser required to use")
    def parse_ini_file(_, _), do: raise("ConfigParser required to use")
    def replace_token_key(_), do: raise("ConfigParser required to use")
  end
end
