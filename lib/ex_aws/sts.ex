defmodule ExAws.STS do

  @moduledoc """
  Operations on AWS STS

  http://docs.aws.amazon.com/STS/latest/APIReference/API_Operations.html
  """

  @type policy :: %{
    binary => :all
  }

  @type get_federation_token_opt :: {:duration, pos_integer} | {:policy, policy}

  @doc "Get Federation Token"
  @spec get_federation_token(name :: String.t, [get_federation_token_opt]) :: ExAws.Operation.Query.t
  def get_federation_token(name, opts) do
    params =
      %{
        "Version" => "2011-06-15",
        "Name" => name,
      }
      |> maybe_add_duration(opts)
      |> maybe_add_policy(opts)

    request(:get_federation_token, params)
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

  defp maybe_add_duration(params, opts) do
    if Keyword.has_key?(opts, :duration) do
      Map.merge(params, %{"DurationSeconds" => opts[:duration]})
    else
      params
    end
  end

  defp maybe_add_policy(params, opts) do
    if Keyword.has_key?(opts, :policy) do
      encoded_policy = Poison.encode!(opts[:policy])

      Map.merge(params, %{"Policy" => encoded_policy})
    else
      params
    end
  end
end
