defmodule ExAws.Auth.PresignedPosts.Policy do
  @moduledoc false
  import ExAws.Auth.Utils

  defstruct [expiration: nil, conditions: []]

  def new do
    %__MODULE__{}
  end

  def set_expiration(policy, datetime) do
    %__MODULE__{policy | expiration: datetime}
  end

  def add_condition(policy = %__MODULE__{conditions: conditions}, condition) do
    new_conditions =
      conditions
      |> Enum.reverse
      |> List.insert_at(0, condition)
      |> Enum.reverse
    %__MODULE__{policy | conditions: new_conditions}
  end

  def encode(policy = %__MODULE__{}, config) do
    policy |> to_map |> config.json_codec.encode! |> Base.encode64
  end

  defp to_map(policy = %__MODULE__{}) do
    %{
      "expiration" => iso_8601_format(policy.expiration),
      "conditions" => policy.conditions
    }
  end
end
