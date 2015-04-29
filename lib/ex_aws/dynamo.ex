defmodule ExAws.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
