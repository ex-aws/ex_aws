defmodule ExAws.MachineLearning do
  use ExAws.MachineLearning.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
