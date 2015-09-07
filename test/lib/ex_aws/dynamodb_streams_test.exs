
defmodule ExAws.Dynamodb.Streams.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Dynamodb.Streams.Client.new
    assert apply(ExAws.Dynamodb.Streams.Core, :list_streams, [client | [%{}]])
  end
end
