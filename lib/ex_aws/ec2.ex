defmodule ExAws.EC2 do
  use ExAws.EC2.Client

  def config_root, do: Application.get_all_env(:ex_aws)  
end