defmodule ExAws.KMSTest do
  use ExUnit.Case, async: true
  alias ExAws.KMS

  @version "2014-11-01"

  test "list_keys" do
    expected =
      %ExAws.Operation.RestQuery{service: :kms,
        params: %{
          "Action"  => "ListKeys",
          "Version" => @version
        },
        path: "/",
        http_method: :post
      }
    assert expected == KMS.list_keys
  end
end
