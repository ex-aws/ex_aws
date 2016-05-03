defmodule ExAws.Route53 do
  use ExAws.Route53.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
