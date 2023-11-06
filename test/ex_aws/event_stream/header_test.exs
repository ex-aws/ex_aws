defmodule ExAws.AuthTest do
  use ExUnit.Case, async: true

  alias ExAws.EventStream.Header

  describe "Header.extract_headers/1" do
    test "can extract Record type event header" do
      assert Header.extract_headers(
               <<13, 58, 109, 101, 115, 115, 97, 103, 101, 45, 116, 121, 112, 101, 7, 0, 5, 101,
                 118, 101, 110, 116, 13, 58, 99, 111, 110, 116, 101, 110, 116, 45, 116, 121, 112,
                 101, 7, 0, 24, 97, 112, 112, 108, 105, 99, 97, 116, 105, 111, 110, 47, 111, 99,
                 116, 101, 116, 45, 115, 116, 114, 101, 97, 109, 11, 58, 101, 118, 101, 110, 116,
                 45, 116, 121, 112, 101, 7, 0, 7, 82, 101, 99, 111, 114, 100, 115>>
             ) == %{
               ":message-type" => "event",
               ":content-type" => "application/octet-stream",
               ":event-type" => "Records"
             }
    end

    test "can extract Stats type event header" do
      assert Header.extract_headers(
               <<13, 58, 109, 101, 115, 115, 97, 103, 101, 45, 116, 121, 112, 101, 7, 0, 5, 101,
                 118, 101, 110, 116, 13, 58, 99, 111, 110, 116, 101, 110, 116, 45, 116, 121, 112,
                 101, 7, 0, 8, 116, 101, 120, 116, 47, 120, 109, 108, 11, 58, 101, 118, 101, 110,
                 116, 45, 116, 121, 112, 101, 7, 0, 5, 83, 116, 97, 116, 115>>
             ) == %{
               ":message-type" => "event",
               ":content-type" => "text/xml",
               ":event-type" => "Stats"
             }
    end

    test "can extract End type event header" do
      assert Header.extract_headers(
               <<13, 58, 109, 101, 115, 115, 97, 103, 101, 45, 116, 121, 112, 101, 7, 0, 5, 101,
                 118, 101, 110, 116, 11, 58, 101, 118, 101, 110, 116, 45, 116, 121, 112, 101, 7,
                 0, 3, 69, 110, 100>>
             ) == %{
               ":message-type" => "event",
               ":event-type" => "End"
             }
    end
  end
end
