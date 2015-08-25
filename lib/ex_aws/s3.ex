defmodule ExAws.S3 do
  use ExAws.S3.Client

  @moduledoc false

  def config_root, do: Application.get_all_env(:ex_aws)
end
