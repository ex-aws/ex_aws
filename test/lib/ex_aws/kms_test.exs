defmodule ExAws.KMSTest do
  use ExUnit.Case, async: true

  test "#list_keys" do
    assert {:ok, %{"Keys" => _keys}} = ExAws.KMS.list_keys |> ExAws.request
  end
end
