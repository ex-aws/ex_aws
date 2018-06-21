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
end
