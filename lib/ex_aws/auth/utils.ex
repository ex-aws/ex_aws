defmodule ExAws.Auth.Utils do

  @moduledoc false

  def uri_encode(url) do
    url
    |> String.replace("+", " ")
    |> URI.encode(&valid_path_char?/1)
  end

  # Space character
  def valid_path_char?(?\ ), do: false
  def valid_path_char?(?/), do: true
  def valid_path_char?(c) do
    URI.char_unescaped?(c) && !URI.char_reserved?(c)
  end

  def hash_sha256(data) do
    :sha256
    |> :crypto.hash(data)
    |> bytes_to_hex
  end

  def hmac_sha256(key, data) do
    :crypto.hmac(:sha256, key, data)
  end

  def bytes_to_hex(bytes) do
    bytes
    |> Base.encode16(case: :lower)
  end

  def service_name(service), do: service |> Atom.to_string

  def method_string(method) do
    method
    |> Atom.to_string
    |> String.upcase
  end

  def date({date, _time}) do
    date |> quasi_iso_format
  end

  def amz_date({date, time}) do
    date = date |> quasi_iso_format
    time = time |> quasi_iso_format

    [date, "T", time, "Z"]
    |> IO.iodata_to_binary
  end

  def quasi_iso_format({y, m, d}) do
    [y, m, d]
    |> Enum.map(&Integer.to_string/1)
    |> Enum.map(&zero_pad/1)
  end

  defp zero_pad(<<_>> = val), do: "0" <> val
  defp zero_pad(val), do: val
end
