defmodule Mix.Tasks.Test.Cleanup do
  alias Mix.Tasks.ExAwsUtil

  def run(_args) do
    Mix.shell().cmd("terraform destroy -auto-approve --var random_suffix=#{ExAwsUtil.random_suffix()}", cd: ExAwsUtil.tf_path())
  end
end
