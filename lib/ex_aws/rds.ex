defmodule ExAws.RDS do
  use ExAws.RDS.Client

  def config_root, do: Application.get_all_env(:ex_aws)  
end