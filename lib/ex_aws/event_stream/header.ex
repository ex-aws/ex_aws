defmodule ExAws.EventStream.Header do
  alias ExAws.EventStream.Prelude

  defp extract_header_bytes(prelude, payload_bytes) do
    binary_part(
      payload_bytes,
      Prelude.prelude_length(),
      prelude.headers_end - Prelude.prelude_length()
    )
  end

  def extract_headers(<<>>, headers) do
    Map.new(headers)
  end

  def extract_headers(<<header_name_size, rest::binary>>, headers) do
    header_name = binary_part(rest, 0, header_name_size)
    # https://docs.aws.amazon.com/AmazonS3/latest/API/RESTSelectObjectAppendix.html
    # +1 and -1  for ignoring first byte here (Always = 0x07) for S3
    # TODO: Support other header data types
    rest =
      binary_part(rest, header_name_size + 1, byte_size(rest) - header_name_size - 1)

    value_size = rest |> binary_part(0, 2) |> :binary.decode_unsigned(:big)

    value =
      binary_part(rest, 2, value_size)

    rest
    |> binary_part(2 + value_size, byte_size(rest) - 2 - value_size)
    |> extract_headers([{header_name, value} | headers])
  end

  def parse(prelude, payload_bytes) do
    headers = prelude |> extract_header_bytes(payload_bytes) |> extract_headers([])
    {:ok, headers}
  end
end
