defmodule ExAws.KinesisFirehose do
  use ExAws.KinesisFirehose.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end
