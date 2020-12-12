defmodule Mix.Tasks.Test.Setup do
  @plan_file "/tmp/ex_aws_test.plan"

  alias Mix.Tasks.ExAwsUtil

  def run(_args) do
    0 = Mix.shell().cmd("terraform plan --var random_suffix=#{ExAwsUtil.random_suffix()} -out=#{@plan_file}", cd: ExAwsUtil.tf_path())

    if Mix.shell().yes?("PLEASE REVIEW THE ABOVE PLAN. Are you sure you wish to make these changes?") do
      0 = Mix.shell().cmd("terraform apply -auto-approve #{@plan_file}", cd: ExAwsUtil.tf_path())
    end
  end
end
