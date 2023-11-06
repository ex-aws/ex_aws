defmodule ExAws.EventStream.Header do
  @moduledoc """
  Parses EventStream headers.

  AWS encodes EventStream headers as follows:

  [header-name-size][header-name][header-data-type][header-value-size][header-value-data]
  |<--  1 byte  -->|<-variable->|<--   1 byte  -->|<--  2 bytes   -->|<--  variable  -->|

  This module parses this information and returns a map of header names - values.
  header-data-type is always 0x07(String) for S3.
  """
  alias ExAws.EventStream.Prelude

  def extract_headers(header_bytes) do
    do_extract_headers(header_bytes, [])
  end

  defp do_extract_headers(<<>>, headers), do: Map.new(headers)

  defp do_extract_headers(<<header_name_size, rest::binary>>, headers) do
    <<header_name::binary-size(header_name_size), _, rest::binary>> = rest
    <<value_size_binary::binary-size(2), rest::binary>> = rest

    value_size = :binary.decode_unsigned(value_size_binary, :big)
    <<value::binary-size(value_size), rest::binary>> = rest

    do_extract_headers(rest, [{header_name, value} | headers])
  end

  defp extract_header_bytes(headers_end, payload_bytes) do
    prelude_length = Prelude.prelude_length()

    <<_prelude::binary-size(prelude_length), headers_bytes::binary-size(headers_end),
      _payload::binary>> = payload_bytes

    headers_bytes
  end

  def parse(%Prelude{headers_length: headers_length}, payload_bytes) do
    headers = headers_length |> extract_header_bytes(payload_bytes) |> extract_headers()
    {:ok, headers}
  end
end
