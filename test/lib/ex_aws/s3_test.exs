defmodule ExAws.S3Test do
  use ExUnit.Case, async: true

  test "#list_buckets" do
    assert {:ok, %{"Functions" => _}} = ExAws.S3.list_buckets
  end

end
