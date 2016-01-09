defmodule Test.Dummy.MachineLearning do
  use ExAws.MachineLearning.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(_client, _action, data, headers), do: data
end

defmodule ExAws.MachineLearningTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.MachineLearning

  ## NOTE:
  # These tests are not intended to be operational examples, but instead merely
  # ensure that the form of the data to be sent to AWS is correct.
  #

  test "#predict" do
    record = %{"Text": "everyday I spend my time drinking wine"}
    assert MachineLearning.predict(record) ==
      %{"Record" => %{Text: "everyday I spend my time drinking wine"}}
  end
end
