defmodule ExAws.Auth.Utils do
  def amz_date(now) do
    now
    |> Timex.DateFormat.format!("{ISOz}")
    |> String.replace("-", "")
    |> String.replace(":", "")
  end

  def valid_path_char?(c) do
    !(c in ':@')
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
    |> Base.encode16
    |> String.downcase
  end

  def service_name(service), do: service |> Atom.to_string

  def method_string(method) do
    method
    |> Atom.to_string
    |> String.upcase
  end
end
