if Code.ensure_loaded?(ConfigParser) do
  defmodule ExAws.CredentialsIni do
    def security_credentials(profile_name) do
      credentials =
        File.read("#{System.user_home}/.aws/credentials")
        |> parse_ini_file(profile_name)
        |> replace_token_key

      config =
        File.read("#{System.user_home}/.aws/config")
        |> parse_ini_file(profile_name)

      Map.merge(credentials, config)
    end

    def parse_ini_file({:ok, contents}, profile_name) do
      parsed_contents = contents
      |> ConfigParser.parse_string

      case parsed_contents do
        {:ok, %{^profile_name => config}} ->
	  config
          |> strip_key_prefix
	{:ok, %{}} -> raise "Missing #{profile_name} entry in configuration"
        _ -> %{}
      end
    end
    def parse_ini_file(_, _), do: %{}

    def strip_key_prefix(credentials) do
      credentials
      |> Enum.filter(fn({key, val}) -> Enum.member?(~w(aws_access_key_id aws_secret_access_key aws_session_token region), key) end)
      |> Enum.reduce(%{}, fn({key, val}, acc) ->
        updated_key = key
        |> String.replace_leading("aws_", "")
        |> String.to_atom
        Map.put(acc, updated_key, val)
      end)
    end

    def replace_token_key(credentials) do
      token = Map.get(credentials, :session_token)

      credentials
      |> Map.delete(:session_token)
      |> Map.put(:security_token, token)
    end
  end
else
  defmodule ExAws.CredentialsIni do
    def security_credentials(_), do: raise "ConfigParser required to use"
    def parse_ini_file(_, _), do: raise "ConfigParser required to use"
    def replace_token_key(_), do: raise "ConfigParser required to use"
  end
end
