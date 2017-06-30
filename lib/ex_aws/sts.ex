defmodule ExAws.STS do

  @moduledoc """
  Operations on AWS STS

  http://docs.aws.amazon.com/STS/latest/APIReference/API_Operations.html
  """

  @type policy :: %{
    binary => :all
  }

  @type assume_role_opt ::
    {:duration, pos_integer} |
    {:serial_number, binary} |
    {:token_code, binary}    |
    {:external_id, binary}   |
    {:policy, policy}

  @doc "Assume Role"
  @spec assume_role(role_arn :: String.t, role_session_name :: String.t, [assume_role_opt]) :: ExAws.Operation.Query.t
  def assume_role(role_arn, role_name, opts \\ []) do
    params = parse_opts(opts)
    |> Map.put("RoleArn", role_arn)
    |> Map.put("RoleSessionName", role_name)

    request(:assume_role, params)
  end

  @doc "Decode Authorization Message"
  @spec decode_authorization_message(message :: String.t) :: ExAws.Operation.Query.t
  def decode_authorization_message(message) do
    request(:decode_authorization_message, %{"EncodedMessage" => message}, %{parser: &ExAws.STS.Parsers.parse/3})
  end

  @doc "Get Caller Identity"
  def get_caller_identity() do
    request(:get_caller_identity, %{})
  end

  @type get_federation_token_opt :: {:duration, pos_integer} | {:policy, policy}

  @doc "Get Federation Token"
  @spec get_federation_token(name :: String.t, [get_federation_token_opt]) :: ExAws.Operation.Query.t
  def get_federation_token(name, opts \\ []) do
    params = parse_opts(opts)
    |> Map.put("Name", name)

    request(:get_federation_token, params)
  end

  @type get_session_token_opt ::
    {:duration, pos_integer} |
    {:serial_number, binary} |
    {:token_code, binary}

  @doc "Get Session Token"
  @spec get_session_token([get_session_token_opt]) :: ExAws.Operation.Query.t
  def get_session_token(opts \\ []) do
    params = parse_opts(opts)

    request(:get_session_token, params)
  end


  ## Request
  ######################

  defp request(action, params, overrides \\ %{}) do
    action_string = action |> Atom.to_string |> Macro.camelize

    params = Map.merge(params, %{
      "Version" => "2011-06-15",
      "Action" => action_string
    })

    %ExAws.Operation.Query{
      path: "/",
      params: params,
      service: :sts,
      action: action,
      parser: &ExAws.STS.Parsers.parse/2
    } |> struct(overrides)
  end

  defp parse_opts(opts) do
    Enum.reduce(opts, %{}, fn item, acc -> parse_opt(acc, item) end)
  end

  defp parse_opt(opts, {:duration, val}), do: Map.put(opts, "DurationSeconds", val)
  defp parse_opt(opts, {:token_code, val}), do: Map.put(opts, "TokenCode", val)
  defp parse_opt(opts, {:serial_number, val}), do: Map.put(opts, "SerialNumber", val)
  defp parse_opt(opts, {:policy, val}), do: Map.put(opts, "Policy", Poison.encode!(val))
end
