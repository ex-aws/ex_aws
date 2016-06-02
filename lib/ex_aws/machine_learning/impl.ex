defmodule ExAws.MachineLearning.Impl do
  use ExAws.Actions
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]

  @moduledoc false
  # Implementation of the AWS Machine Learning API.
  # Only Predict for now.
  #
  # See ExAws.MachineLearning.Client for usage.

  @namespace "AmazonML_20141212"
  @actions [
    predict: :post,
  ]

  def predict(client, record \\ %{}) do
    data = %{ "Record" => record }
    request(client, :predict, data)
  end

  defp request(%{__struct__: client_module} = client, action, data, headers \\ []) do
    client_module.request(client, action, data, headers)
  end
end
