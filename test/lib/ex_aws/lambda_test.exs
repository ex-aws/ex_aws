defmodule ExAws.LambdaTest do
  use ExUnit.Case, async: true

  test "#list_functions" do
    assert {:ok, %{"Functions" => _}} = ExAws.Lambda.list_functions |> ExAws.request
  end

  test "callback on invoke works for encoding context" do
    op = ExAws.Lambda.invoke("yo", "dawg", "asdfasdf")
    assert {"X-Amz-Client-Context", header} = op.before_request.(op, %{json_codec: Poison}).headers |> List.keyfind("X-Amz-Client-Context", 0)
    assert header == "ImFzZGZhc2RmIg=="
  end

end
