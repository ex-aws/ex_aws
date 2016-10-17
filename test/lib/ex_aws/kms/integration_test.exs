defmodule ExAws.KMS.IntegrationTest do
  use ExUnit.Case, async: true

  test "#list_keys" do
    assert {:ok, %{body: body}} = ExAws.KMS.list_keys |> ExAws.request

    [ head | _tail ] = body

    assert Map.has_key?(head, :key_id)
    assert Map.has_key?(head, :key_arn)
  end
end
