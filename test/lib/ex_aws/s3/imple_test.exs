defmodule ExAws.S3.ImplTest do
  use ExUnit.Case, async: true
  alias ExAws.S3.Impl

  test "#build_cors_rule" do
    rule = %{allowed_origins: ["*"], allowed_headers: ["foo", "bar"], max_age_seconds: 45}
    assert rule |> Impl.build_cors_rule ==
    "<CORSRule><MaxAgeSeconds>45</MaxAgeSeconds><AllowedOrigin>*</AllowedOrigin><AllowedHeader>foo</AllowedHeader><AllowedHeader>bar</AllowedHeader></CORSRule>"
  end

  test "from_options/2" do
    params = [:foo, :bar_baz, yo: "dawg"]
    opts = %{foo: "foo", bar_baz: "bar_baz", yo: "yo"}
    assert %{"foo" => "foo", "bar-baz" => "bar_baz", "dawg" => "yo"} == opts
    |> Impl.format_and_take(params)
  end

  test "format_grant_headers/2" do
    headers = [:acl, :grant_read, :grant_write, :grant_read_acp, :grant_write_acp, :grant_full_control]
    grants = %{grant_read: [email: "foo@bar.com", id: "fake_id"]}
    assert grants |> Impl.format_grant_headers(headers) ==
      [{"x-amz-grant-read", "emailAddress=\"foo@bar.com\", id=\"fake_id\""}]
  end
end
