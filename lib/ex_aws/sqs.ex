defmodule ExAws.SQS do
  use ExAws.SQS.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
