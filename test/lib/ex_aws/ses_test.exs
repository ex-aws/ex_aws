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
end
