defmodule ExAws.AuthCache.DefaultConfigProvider do
  @moduledoc false

  @behaviour ExAws.Config.AuthCache.AuthConfigProvider

  @impl true
  def auth_config_for(profile, _expiration) do
    ExAws.CredentialsIni.security_credentials(profile)
  end

end
