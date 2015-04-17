defmodule ExAws.Lambda do
  use ExAws.Lambda.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
