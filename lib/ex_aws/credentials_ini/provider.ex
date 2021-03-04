defmodule ExAws.CredentialsIni.Provider do
  @moduledoc """
  Specifies expected behaviour of a credentials provider.

  A credentials initializer provider is a module that fetches the AWS credentials from different sources.
  """

  @type profile :: String.t()
  @type credentials :: map()

  @callback security_credentials(profile) :: credentials
end
