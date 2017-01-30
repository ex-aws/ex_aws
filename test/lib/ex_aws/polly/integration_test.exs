defmodule ExAws.PollyTest do
  use ExUnit.Case, async: true

  test "#describe_voices" do
    assert {:ok, resp} = ExAws.Polly.describe_voices |> ExAws.request
    assert %{"Voices" => _, "NextToken" => _} = resp
  end
end
