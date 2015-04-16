defmodule ExAws.Dynamo do
  use ExAws.Dynamo.Adapter

  def config_root, do: Application.get_all_env(:ex_aws)
end
