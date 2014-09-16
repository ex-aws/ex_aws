defmodule ExAws.Kinesis do
  alias __MODULE__
  alias ExAws.Config

  # This function should be used for everything.
  def request(action) do
    request(action, [])
  end

  def request(action, data) do
    :erlcloud_kinesis_impl.request(Config.erlcloud_config, Kinesis.Actions.get(action), Config.namespace(data, :kinesis))
  end

end
