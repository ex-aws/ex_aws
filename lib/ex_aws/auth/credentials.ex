defmodule ExAws.Auth.Credentials do
  @moduledoc false

  import ExAws.Auth.Utils, only: [date: 1]

  def generate_credential_v4(service, config, datetime) do
    scope = generate_credential_scope_v4(service, config, datetime)
    "#{config[:access_key_id]}/#{scope}"
  end

  def generate_credential_scope_v4(service, config, datetime) do
    "#{date(datetime)}/#{config[:region]}/#{service}/aws4_request"
  end
end
