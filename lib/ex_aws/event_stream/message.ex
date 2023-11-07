defmodule ExAws.EventStream.Message do
  alias ExAws.EventStream.Prelude
  alias ExAws.EventStream.Header
  import Bitwise

  defstruct prelude: nil,
            headers: nil,
            payload: nil

  def verify_message_crc(
        %Prelude{
          crc: prelude_crc,
          payload_length: payload_length,
          headers_length: headers_length
        },
        payload_bytes
      ) do
    <<_::binary-size(8), message_bytes::binary-size(payload_length + headers_length + 4),
      message_crc_bytes::binary-size(4)>> = payload_bytes

    message_crc = :binary.decode_unsigned(message_crc_bytes, :big)

    if :erlang.crc32(prelude_crc, message_bytes) |> band(0xFFFFFFFF) == message_crc do
      :ok
    else
      {:error, :message_checksum_mismatch}
    end
  end

  def parse_payload(
        %Prelude{
          prelude_length: prelude_length,
          headers_length: headers_length,
          payload_length: payload_length
        },
        payload_bytes
      ) do
    <<_prelude_headers::binary-size(prelude_length + headers_length),
      message_bytes::binary-size(payload_length), _::binary>> = payload_bytes

    {:ok, message_bytes}
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
