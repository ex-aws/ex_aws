defmodule ExAws.KMS do
  @moduledoc """
  Operations on AWS KMS
  """

  import ExAws.Utils

  @version "2014-11-01"

  def get_key_rotation_status(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GetKeyRotationStatus",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:get_key_rotation_status, query_params)
  end

  @spec list_keys() :: ExAws.Operation.JSON.t
  def list_keys(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeys",
          "Version" => @version
                 })

    request(:list_keys, query_params)
  end

  def generate_data_key(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GenerateDataKey",
          "Version" => @version,
          "KeyId"   => key_id,
          "KeySpec" => opts[:key_spec] || "AES_256"
                 })

    request(:generate_data_key, query_params)
  end

  def decrypt(ciphertext, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "Decrypt",
          "Version" => @version,
          "CiphertextBlob"   => ciphertext,
                 })

    request(:decrypt, query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:kms, %{
          data: params,
          headers: [
            {"x-amz-target", "TrentService.#{operation}"},
            {"content-type", "application/x-amz-json-1.0"},
          ]
    } |> Map.merge(opts))
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
