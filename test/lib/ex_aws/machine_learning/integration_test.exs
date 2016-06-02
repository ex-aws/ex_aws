defmodule ExAws.MachineLearningIntegrationTest do
  use ExUnit.Case, async: true

  test "#predict" do
    record = %{"Text": "What is going on"}

    assert {:ok, %{"Prediction" => prediction}} = ExAws.MachineLearning.predict(record)
    assert Map.has_key?(prediction, "predictedLabel")
  end
end
