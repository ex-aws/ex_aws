defmodule Test.ClientData.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(client_data, _data, _action), do: client_data
end

defmodule ExAws.Dynamo.ImplTest do
  use ExUnit.Case, async: true
  test "custom config is allowed" do
    config = Test.ClientData.Dynamo.config
    |> Keyword.put(:secret_access_key, "foo")

    assert ExAws.Dynamo.Impl.list_tables(Test.ClientData.Dynamo.new(config: config))
    |> Map.get(:config)
    |> Keyword.get(:secret_access_key) == "foo"
  end
end
