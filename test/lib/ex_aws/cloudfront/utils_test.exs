defmodule ExAws.CloudFront.UtilsTest do
  use ExUnit.Case, async: true

  alias ExAws.CloudFront.Utils

  test "urlify/1" do
    assert "A-a~b_c" == Utils.urlify "A+a/b=c"
  end

  test "deurlify/1" do
    assert "A+a/b=c" == Utils.deurlify "A-a~b_c"
  end

  test "aws_encode64/1 should urlify encoded string" do
    assert "FPucA9l-" == Utils.aws_encode64 <<0x14, 0xfb, 0x9c, 0x03, 0xd9, 0x7e>>
  end

  test "aws_decode64/1 should deurlify decoded string" do
    assert <<0x14, 0xfb, 0x9c, 0x03, 0xd9, 0x7e>> == Utils.aws_decode64 "FPucA9l-"
  end
end
