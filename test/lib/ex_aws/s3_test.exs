defmodule Test.Dummy.S3 do
  use ExAws.S3.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(http_method, bucket, path, data \\ []) do
    data
    |> Enum.into(%{})
    |> Map.put(:path, path)
  end
end

defmodule ExAws.S3Test do
  use ExUnit.Case, async: true
  alias Test.Dummy.S3

  test "#get_object" do
    assert S3.get_object("bucket", "object.json", %{response: %{content_type: "application/json"}}) ==
      %{headers: %{response: %{content_type: "application/json"}}, params: %{},
        path: "object.json"}
  end

end
