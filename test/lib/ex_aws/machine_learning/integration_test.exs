defmodule ExAws.MachineLearningIntegrationTest do
  use ExUnit.Case, async: true

  test "#predict" do
    modelId = "ml-Ry8sJUCy97V"
    record = %{"Text": "What is going on"}

    assert {:ok, %{"Prediction" => prediction}} = ExAws.MachineLearning.predict(modelId, record)
    assert Map.has_key?(prediction, "predictedLabel")
  end
end
