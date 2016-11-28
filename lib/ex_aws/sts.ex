defmodule ExAws.STS do

  @moduledoc """
  Operations on AWS STS

  http://docs.aws.amazon.com/STS/latest/APIReference/API_Operations.html
  """

  @type policy :: %{
    binary => :all
  }

  @type get_federation_token_params :: %{
    :duration => pos_integer(),
    :name => binary,
    :policy => policy
  }

  @doc "Get Federation Token"
  @spec get_federation_token(params :: get_federation_token_params) :: ExAws.Operation.Query.t
  def get_federation_token(%{duration: duration, name: name, policy: policy}) do
    request(:get_federation_token, %{
      "Version" => "2011-06-15",
      "DurationSeconds" => duration,
      "Name" => name,
      "Policy" => Poison.encode!(policy),
    })
  end

  ## Request
  ######################

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string),
      service: :sts,
      action: action,
      parser: &ExAws.STS.Parsers.parse/2
    }
  end
end
