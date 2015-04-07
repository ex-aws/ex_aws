defmodule Test.User do
  @derive [ExAws.Dynamo.Conversion]
  defstruct [:email, :name, :age, :admin]
end

defmodule Test.Dynamo do
  use ExAws.Dynamo.Adapter

  def config do
    Application.get_env(:ex_aws, :dynamodb)
  end
end


ExUnit.start()
