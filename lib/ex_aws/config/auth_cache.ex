defmodule ExAws.Config.AuthCache do
  use GenServer

  @moduledoc false

  # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(config) do
    case :ets.lookup(__MODULE__, :aws_instance_auth) do
      [{:aws_instance_auth, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_config, config}, 30_000)
    end
  end

  def get(profile, expiration) do
    case :ets.lookup(__MODULE__, :awscli) do
      [{:awscli, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_awscli_config, profile, expiration}, 30_000)
    end
  end

  def use_awscli_filenames(config_file, credentials_file) do
    GenServer.call(__MODULE__, {:use_awscli_filenames, {config_file, credentials_file}})
  end

  ## Callbacks

  def init(:ok) do
    ets = :ets.new(__MODULE__, [:named_table, read_concurrency: true])
    {:ok, ets}
  end

  def handle_call({:refresh_config, config}, _from, ets) do
    auth = refresh_config(config, ets)
    {:reply, auth, ets}
  end
  def handle_call({:refresh_awscli_config, profile, expiration}, _from, ets) do
    auth = refresh_awscli_config(profile, expiration, ets)
    {:reply, auth, ets}
  end
  def handle_call({:use_awscli_filenames, filenames}, _from, ets) do
    :ets.insert(ets, {:awscli_filenames, filenames})
    :ets.delete(ets, :awscli)
    {:reply, filenames, ets}
  end

  def handle_info({:refresh_config, config}, ets) do
    refresh_config(config, ets)
    {:noreply, ets}
  end
  def handle_info({:refresh_awscli_config, profile, expiration}, ets) do
    refresh_awscli_config(profile, expiration, ets)
    {:noreply, ets}
  end

  defp refresh_awscli_config(profile, expiration, ets) do
    auth = ExAws.CredentialsIni.security_credentials(profile, get_awscli_filenames(ets))
    :ets.insert(ets, {:awscli, auth})
    Process.send_after(self(), {:refresh_awscli_config, profile, expiration}, expiration)
    auth
  end

  defp get_awscli_filenames(ets) do
    case :ets.lookup(ets, :awscli_filenames) do
      [{:awscli_filenames, filenames}] -> filenames
      _ -> nil
    end
  end

  defp refresh_config(config, ets) do
    auth = ExAws.InstanceMeta.security_credentials(config)
    :ets.insert(ets, {:aws_instance_auth, auth})
    Process.send_after(self(), {:refresh_config, config}, refresh_in(auth[:expiration]))
    auth
  end

  defp refresh_in(expiration) do
    expiration = expiration |> ExAws.Utils.iso_z_to_secs
    time_to_expiration = expiration - ExAws.Utils.now_in_seconds
    refresh_in = time_to_expiration - 5 * 60 # check five mins prior to expiration
    max(0, refresh_in * 1000) # check now if we should have checked in the past
  end
end
