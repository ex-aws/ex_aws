defmodule ExAws.LambdaTest do
  use ExUnit.Case, async: true

  test "#list_functions" do
    assert {:ok, %{"Functions" => _}} = ExAws.Lambda.list_functions
  end

end
