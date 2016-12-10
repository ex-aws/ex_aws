defmodule ExAws.SES do
  @moduledoc """
  Operations on AWS SES

  http://docs.aws.amazon.com/ses/latest/APIReference/Welcome.html
  """

  @doc "Verifies an email address"
  @spec verify_email_identity(email :: binary) :: ExAws.Operation.Query.t
  def verify_email_identity(email) do
    request(:verify_email_identity, %{"EmailAddress" => email})
  end

  @doc "Fetch identities verification status and token (for domains)"
  @spec identity_verification_attributes([binary]) :: ExAws.Operation.Query.t
  def identity_verification_attributes(identities) when is_list(identities) do
    params =
      identities
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({identity, index}, params) ->
        Map.put_new(params, "Identities.member.#{index + 1}", identity)
      end)

    request(:get_identity_verification_attributes, params)
  end

  ## Request
  ######################

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string),
      service: :ses,
      action: action,
      parser: &ExAws.SES.Parsers.parse/2
    }
  end
end
