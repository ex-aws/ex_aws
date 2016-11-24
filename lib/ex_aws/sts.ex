defmodule ExAws.STS do

  @moduledoc """
  Operations on AWS STS

  http://docs.aws.amazon.com/STS/latest/APIReference/API_Operations.html
  """

  @doc "Get Federation Token"
  @spec get_federation_token(duration :: pos_integer(), name :: binary, policy :: map()) :: ExAws.Operation.Query.t
  def get_federation_token(duration, name, policy) do
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
