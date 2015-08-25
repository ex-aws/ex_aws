defmodule ExAws.CloudSearch do
  use ExAws.CloudSearch.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
