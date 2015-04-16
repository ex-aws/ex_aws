defmodule ExAws.Lambda do
  use ExAws.Lambda.Adapter

  def config_root, do: Application.get_all_env(:ex_aws)
end
