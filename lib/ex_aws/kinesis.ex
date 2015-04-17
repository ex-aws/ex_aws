defmodule ExAws.Kinesis do
  use ExAws.Kinesis.Client

  def config_root, do: Application.get_all_env(:ex_aws)

end
