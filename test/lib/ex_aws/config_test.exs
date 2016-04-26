defmodule ExAws.ConfigTest do
  use ExUnit.Case, async: true

  test "{:system} style configs work" do
    value = "foo"
    System.put_env("ExAwsConfigTest", value)
    assert %{__struct__: %{config_root: [access_key_id: {:system, "ExAwsConfigTest"}]}, config: %{}, service: :foo}
    |> ExAws.Config.build
    |> Map.get(:config)
    |> Map.get(:access_key_id) == value
  end
end
