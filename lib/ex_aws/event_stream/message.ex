defmodule ExAws.EventStream.Message do
  alias ExAws.EventStream.Prelude
  alias ExAws.EventStream.Header
  import Bitwise

  defstruct prelude: nil,
            headers: nil,
            payload: nil

  def validate_checksum(message_bytes, message_crc, prelude_crc) do
    if :erlang.crc32(prelude_crc, message_bytes) |> band(0xFFFFFFFF) == message_crc do
      :ok
    else
      {:error, :message_checksum_mismatch}
    end
  end

  def verify_message_crc(prelude, payload_bytes) do
    message_crc =
      payload_bytes
      |> binary_part(prelude.payload_end, 4)
      |> :binary.decode_unsigned(:big)

    message_length = prelude.payload_end - (Prelude.prelude_length() - 4)

    message_bytes =
      binary_part(
        payload_bytes,
        Prelude.prelude_length() - 4,
        message_length
      )

    validate_checksum(message_bytes, message_crc, prelude.crc)
  end

  def parse_payload(prelude, payload_bytes) do
    {:ok, binary_part(payload_bytes, prelude.headers_end, prelude.payload_length)}
  end

  def is_record?(%__MODULE__{headers: headers}) do
    Map.get(headers, ":event-type") == "Records"
  end

  def get_payload(%__MODULE__{payload: payload}) do
    payload
  end

  def parse(chunk) do
    with {:ok, prelude, payload_bytes} <-
           Prelude.parse(chunk),
         :ok <- verify_message_crc(prelude, payload_bytes),
         {:ok, headers} <- Header.parse(prelude, payload_bytes),
         {:ok, payload} <- parse_payload(prelude, payload_bytes) do
      {:ok, %__MODULE__{prelude: prelude, payload: payload, headers: headers}}
    end
  end
end
