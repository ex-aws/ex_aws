
defmodule ExAws.SNS.ParserTest do
  use ExUnit.Case, async: true

  alias ExAws.SES.Parsers

  def to_success(doc) do
    {:ok, %{body: doc}}
  end

  def to_error(doc) do
    {:error, {:http_error, 403, %{body: doc}}}
  end

  test "#parsing a verify_email_identity response" do
    rsp = """
      <VerifyEmailIdentityResponse xmlns="http://ses.amazonaws.com/doc/2010-12-01/">
      <VerifyEmailIdentityResult/>
        <ResponseMetadata>
          <RequestId>d8eb8250-be9b-11e6-b7f7-d570946af758</RequestId>
        </ResponseMetadata>
      </VerifyEmailIdentityResponse>
    """
    |> to_success


    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :verify_email_identity)
    assert parsed_doc == %{request_id: "d8eb8250-be9b-11e6-b7f7-d570946af758"}
  end
end
