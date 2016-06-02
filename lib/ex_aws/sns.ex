defmodule ExAws.SNS do
  use ExAws.SNS.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
