defmodule Test.ClientData.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(client, _action, _data), do: client
end

defmodule ExAws.Dynamo.ImplTest do
  use ExUnit.Case, async: true

  test "custom config is allowed" do
    assert Test.ClientData.Dynamo.new(secret_access_key: "foo")
    |> ExAws.Dynamo.Impl.list_tables
    |> Map.get(:config)
    |> Map.get(:secret_access_key) == "foo"
  end

end
