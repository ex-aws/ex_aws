defmodule ExAws.EventStream.Prelude do
  defstruct total_length: nil,
            headers_length: nil,
            crc: nil,
            payload_length: nil,
            payload_end: nil,
            headers_end: nil,
            prelude_bytes: nil

  @prelude_length 12
  # 128 Kb
  @max_header_length 128 * 1024
  # 16 Mb
  @max_payload_length 16 * 1024 * 1024

  def prelude_length(), do: @prelude_length

  defp unpack_prelude(
         <<
           total_length::binary-size(4),
           headers_length::binary-size(4),
           crc::binary-size(4)
         >> = prelude_bytes
       ) do
    total_length = :binary.decode_unsigned(total_length, :big)
    headers_length = :binary.decode_unsigned(headers_length, :big)
    crc = :binary.decode_unsigned(crc, :big)

    # The extra minus 4 bytes is for the message CRC.
    payload_length = total_length - @prelude_length - headers_length - 4
    payload_end = total_length - 4
    headers_end = @prelude_length + headers_length

    {:ok,
     %__MODULE__{
       total_length: total_length,
       headers_length: headers_length,
       crc: crc,
       payload_length: payload_length,
       payload_end: payload_end,
       headers_end: headers_end,
       prelude_bytes: prelude_bytes
     }}
  end

  def validate_prelude(prelude) do
    cond do
      prelude.headers_length > @max_header_length ->
        {:error, :invalid_headers_length}

      prelude.payload_length > @max_payload_length ->
        {:error, :invalid_payload_length}

      true ->
        {:ok, prelude}
    end
  end

  def validate_checksum(%__MODULE__{
        prelude_bytes: <<prelude_bytes::binary-size(@prelude_length - 4), _rest::binary>>,
        crc: checksum
      }) do
    if :erlang.crc32(prelude_bytes) == checksum do
      :ok
    else
      {:error, :prelude_checksum_mismatch}
    end
  end

  def parse(<<prelude_bytes::binary-size(@prelude_length), _rest::binary>> = payload) do
    with {:ok, unpacked_prelude} <- unpack_prelude(prelude_bytes),
         {:ok, prelude} <- validate_prelude(unpacked_prelude),
         :ok <- validate_checksum(prelude) do
      {:ok, prelude, payload}
    end
  end
end
