defmodule ExAws.Auth.UtilsTest do
  use ExUnit.Case, async: true
  import ExAws.Auth.Utils

  test "quasi_iso_date/1" do
    assert quasi_iso_format({2015, 1, 2}) == ["2015", "01", "02"]
    assert quasi_iso_format({2015, 11, 12}) == ["2015", "11", "12"]
  end

  test "amz_date/1" do
    assert amz_date({{2015, 1, 2}, {1, 3, 5}}) == "20150102T010305Z"
    assert amz_date({{2015, 11, 22}, {11, 31, 51}}) == "20151122T113151Z"
  end

  test "uri_encode/1" do
    assert uri_encode("http://test-domain.com/abc+123") == "http%3A//test-domain.com/abc%2B123"
    assert uri_encode("http://test-domain.com/abc+123?param_1=1+1&param_2=2+2") == "http%3A//test-domain.com/abc%2B123%3Fparam_1%3D1%201%26param_2%3D2%202"
  end
end
