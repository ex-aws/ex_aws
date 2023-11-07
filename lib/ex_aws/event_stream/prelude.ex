defmodule ExAws.EventStream.Prelude do
  import Bitwise

  defstruct total_length: nil,
            headers_length: nil,
            prelude_length: nil,
            crc: nil,
            payload_length: nil,
            prelude_bytes: nil

  @prelude_length 12
  # 128 Kb
  @max_header_length 128 * 1024
  # 16 Mb
  @max_payload_length 16 * 1024 * 1024

  defp unpack_prelude(
         <<
           total_length_bytes::binary-size(4),
           headers_length_bytes::binary-size(4),
           crc::binary-size(4)
         >> = prelude_bytes
       ) do
    total_length = :binary.decode_unsigned(total_length_bytes, :big)
    headers_length = :binary.decode_unsigned(headers_length_bytes, :big)
    crc = :binary.decode_unsigned(crc, :big)

    {:ok,
     %__MODULE__{
       total_length: total_length,
       headers_length: headers_length,
       prelude_length: @prelude_length,
       payload_length: total_length - @prelude_length - headers_length - 4,
       crc: crc,
       prelude_bytes: prelude_bytes
     }}
  end

  def validate_prelude(
        %__MODULE__{
          headers_length: headers_length,
          payload_length: payload_length
        } = prelude
      ) do
    cond do
      headers_length > @max_header_length ->
        {:error, :invalid_headers_length}

      payload_length > @max_payload_length ->
        {:error, :invalid_payload_length}

      true ->
        {:ok, prelude}
    end
  end

  def validate_checksum(
        <<prelude_bytes_without_crc::binary-size(@prelude_length - 4), _rest::binary>>,
        prelude_checksum
      ) do
    computed_checksum = prelude_bytes_without_crc |> :erlang.crc32() |> band(0xFFFFFFFF)

    if computed_checksum == prelude_checksum do
      :ok
    else
      {:error, :prelude_checksum_mismatch}
    end
  end

  def parse(<<prelude_bytes::binary-size(@prelude_length), _rest::binary>> = payload) do
    with {:ok, unpacked_prelude} <- unpack_prelude(prelude_bytes),
         {:ok, prelude} <- validate_prelude(unpacked_prelude),
         :ok <- validate_checksum(prelude_bytes, unpacked_prelude.crc) do
      {:ok, prelude, payload}
    end
  end
end
