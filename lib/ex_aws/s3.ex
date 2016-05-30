defmodule ExAws.S3 do
  use ExAws.S3.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
