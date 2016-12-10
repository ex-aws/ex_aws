defmodule ExAws.SES do
  #import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1]

  @moduledoc """
  Operations on AWS SES

  http://docs.aws.amazon.com/ses/latest/APIReference/Welcome.html
  """

  @doc "Verifies an email address"
  @spec verify_email_identity(email :: binary) :: ExAws.Operation.Query.t
  def verify_email_identity(email) do
    request(:verify_email_identity, %{"EmailAddress" => email})
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
