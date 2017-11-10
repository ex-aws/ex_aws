defmodule ExAws.Auth.SignaturesTest do
  use ExUnit.Case, async: true
  alias ExAws.Auth.Signatures

  describe "generate_signature_v4/4" do
    test "with a basic string to sign" do
      config = ExAws.Config.new(:s3, [
        access_key_id: "AKIAIOSFODNN7EXAMPLE",
        secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        region: "us-east-1"
      ])
      datetime = {{2016,8,29},{19,41,33}}

      signature = Signatures.generate_signature_v4("s3", config, datetime, "hello world")

      assert signature == "690b8431208dae486dd00df93bde9370d8aba587098b9a26bfd07c259df395c9"
    end
  end
end
