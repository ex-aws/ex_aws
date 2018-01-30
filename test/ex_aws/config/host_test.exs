defmodule ExAws.Config.HostTest do
  use ExUnit.Case, async: true

  import ExAws.Config.Host

  test "uses specified hostname when set for service and region" do
    assert get_host(:sts, "ap-northeast-2") == "sts.ap-northeast-2.amazonaws.com"
  end

  test "uses partition's default when hostname not specified for service and name" do
    assert get_host(:sts, "us-east-1") == "sts.us-east-1.amazonaws.com"
  end

  test "supports non-regionalized services in standard partition" do
    assert get_host(:iam, "eu-west-1") == "iam.amazonaws.com"
  end

  test "supports non-standard partitions" do
    assert get_host(:iam, "cn-north-1") == "iam.cn-north-1.amazonaws.com.cn"
    assert get_host(:sts, "us-gov-west-1") == "sts.us-gov-west-1.amazonaws.com"
  end
end
