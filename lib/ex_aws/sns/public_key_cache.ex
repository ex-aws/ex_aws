defmodule ExAws.SNS.PublicKeyCache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(certUrl) do
      case :ets.lookup(__MODULE__, certUrl) do
        [{certUrl, public_key}] -> {:ok, public_key}
        [] -> GenServer.call(__MODULE__, {:get_public_key, certUrl})
    end
  end

  ## Callbacks

  def init(:ok) do
    ets = :ets.new(__MODULE__, [:named_table, read_concurrency: true])
    {:ok, ets}
  end

  def handle_call({:get_public_key, certUrl}, _from, ets) do
    with {:ok, cert} <- fetch_certificate(certUrl),
      {:ok, public_key} <- get_public_key(cert) do
        :ets.insert(__MODULE__, {certUrl, public_key})
        {:reply, {:ok, public_key}, ets}
    else
      error -> {:reply, error, ets}
    end
  end

  defp fetch_certificate(cert_url) do
    with {:ok, 200, _resp_headers, client} <- :hackney.get(cert_url, [], "", []),
      {:ok, cert_binary} <- :hackney.body(client) do
        get_pem_entry(:public_key.pem_decode(cert_binary))  
    else
      {:ok, status_code, _resp_headers, _client} -> {:error, "Could not fetch certificate from #{cert_url}, expected http code 200, got: #{status_code}"}
      {:error, error} -> {:error, "Unexpected error, could not fetch certificate from #{cert_url}, got #{inspect error}"}
    end
  end

  defp get_pem_entry(pem_entries) do
    case length(pem_entries) do
      0 -> {:error, "invalid argument"}
      x when x > 1 -> {:error, "found multiple PEM entries, expected only 1"}
      x when x == 1 ->
        try do
          {:ok, :public_key.pem_entry_decode(Enum.at(pem_entries, 0))}
        catch
          kind, error -> {:error, "Unexpected error while decoding pem entry: #{inspect error}"}
        end
    end
  end  
  
  defp get_public_key(cert) do
    {:ok, :public_key.der_decode(:RSAPublicKey, cert |> elem(1) |> elem(7) |> elem(2))}
  end

end
