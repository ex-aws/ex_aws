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

  describe "#send_email" do
    test "with required params only" do
      dst =  %{to_addresses:  ["success@simulator.amazonses.com"]}
      msg = %{body: %{}, subject: %{data: "subject"}}
      expected = %{
        "Action" => "SendEmail", "Destination.ToAddresses.member.1" => "success@simulator.amazonses.com",
        "Message.Subject.Data" => "subject", "Source" => "user@example.com"
      }

      assert expected == SES.send_email(dst, msg, "user@example.com").params
    end

    test "with all optional params" do
      dst =  %{
        bcc_addresses: ["success@simulator.amazonses.com"],
        cc_addresses:  ["success@simulator.amazonses.com"],
        to_addresses:  ["success@simulator.amazonses.com", "bounce@simulator.amazonses.com"]
      }
      msg = SES.build_message("html", "text", "subject")

      expected = %{
        "Action" => "SendEmail", "ConfigurationSetName" => "test",
        "Destination.ToAddresses.member.1" => "success@simulator.amazonses.com",
        "Destination.ToAddresses.member.2" => "bounce@simulator.amazonses.com",
        "Destination.CcAddresses.member.1" => "success@simulator.amazonses.com",
        "Destination.BccAddresses.member.1" => "success@simulator.amazonses.com",
        "Message.Body.Html.Data" => "html", "Message.Body.Html.Charset" => "UTF-8",
        "Message.Body.Text.Data" => "text", "Message.Body.Text.Charset" => "UTF-8",
        "Message.Subject.Data" => "subject", "Message.Subject.Charset" => "UTF-8",
        "ReplyToAddresses.member.1" => "user@example.com", "ReplyToAddresses.member.2" => "user1@example.com",
        "ReturnPath" => "feedback@example.com",
        "ReturnPathArn" => "arn:aws:ses:us-east-1:123456789012:identity/example.com",
        "Source" => "user@example.com",
        "SourceArn" => "east-1:123456789012:identity/example.com",
        "Tags.member.1.Name" => "tag1", "Tags.member.1.Value" => "tag1value1",
        "Tags.member.2.Name" => "tag2", "Tags.member.2.Value" => "tag2value1"
      }

      assert expected == ExAws.SES.send_email(
        dst, msg, "user@example.com", configuration_set_name: "test", return_path: "feedback@example.com",
        return_path_arn: "arn:aws:ses:us-east-1:123456789012:identity/example.com",
        source_arn: "east-1:123456789012:identity/example.com",
        reply_to_addresses: ["user@example.com", "user1@example.com"],
        tags:  [%{name: "tag1", value: "tag1value1"}, %{name: "tag2", value: "tag2value1"}]
      ).params
    end
  end
end
