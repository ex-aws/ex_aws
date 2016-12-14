defmodule ExAws.SESTest do
  use ExUnit.Case, async: true
  alias ExAws.SES

  setup_all do
    {:ok, email: "user@example.com"}
  end

  test "#verify_email_identity", ctx do
    expected = %{"Action" => "VerifyEmailIdentity", "EmailAddress" => ctx.email}
    assert expected == SES.verify_email_identity(ctx.email).params
  end

  test "#identity_verification_attributes", ctx do
    expected = %{
      "Action" => "GetIdentityVerificationAttributes",
      "Identities.member.1" => ctx.email
    }

    assert expected == SES.identity_verification_attributes([ctx.email]).params
  end

  test "#configuration_sets" do
    expected = %{"Action" => "ListConfigurationSets", "MaxItems" => 1, "NextToken" => "QUFBQUF"}
    assert expected == SES.configuration_sets(max_items: 1, next_token: "QUFBQUF").params
  end
end
