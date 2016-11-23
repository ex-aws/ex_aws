defmodule CredentialsFile do

  require Ini

  def load_profile(profile) do
    {:ok, data} = File.read Path.expand("~/.aws/credentials")
    case Ini.decode(data)[profile] do
      nil -> raise "Could not find profile"
      config ->
	%{access_key_id: config[:aws_access_key_id],
	 secret_access_key: config[:aws_secret_access_key],
	 security_token: config[:aws_session_token] || ""}
    end
  end
end
