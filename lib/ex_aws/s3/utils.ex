defmodule ExAws.S3.Utils do
  ## Formatting and helpers
  @moduledoc false

  @doc """
  format_and_take %{param_one: "v1", param_two: "v2"}, [:param_one]
  #=> %{"param-one" => "v1"}
  """
  def format_and_take(%{} = opts, param_list) do
    param_list
    |> Enum.map(&{&1, normalize_param(&1)})
    |> Enum.reduce(%{}, fn({elixir_opt, aws_opt}, params) ->
      case Map.get(opts, elixir_opt) do
        nil   -> params
        value -> Map.put(params, aws_opt, value)
      end
    end)
  end

  def format_and_take(opts, param_list) do
    opts
    |> Enum.into(%{})
    |> format_and_take(param_list)
  end

  def format_grant_headers(grants, headers) do
    grants
    |> format_and_take(headers)
    |> namespace("x-amz")
    |> Enum.into(%{}, &format_grant_header/1)
  end

  def format_grant_header({permission, grantees}) do
    grants = grantees
    |> Enum.map(fn
      {:email, email} -> "emailAddress=\"#{email}\""
      {key, value}    -> "#{key}=\"#{value}\""
    end)
    |> Enum.join(", ")

    {permission, grants}
  end

  def build_cors_rule(rule) do
    mapping = [
      allowed_origins: "AllowedOrigin",
      allowed_methods: "AllowedMethod",
      allowed_headers: "AllowedHeader",
      exposed_headers: "ExposeHeader"]

    properties = mapping
    |> Enum.flat_map(fn({key, property}) ->
      rule
      |> Map.get(key, [])
      |> Enum.map(&("<#{property}>#{&1}</#{property}>"))
    end)
    |> IO.iodata_to_binary

    properties = case Map.get(rule, :max_age_seconds) do
      nil -> properties
      value -> "<MaxAgeSeconds>#{value}</MaxAgeSeconds>" <> properties
    end

    "<CORSRule>#{properties}</CORSRule>"
  end

  def normalize_param(param) when is_atom(param) do
    param
    |> Atom.to_string
    |> String.replace("_", "-")
  end
  def normalize_param(other), do: other

  def namespace(list, value) do
    list
    |> Stream.map(fn {k ,v} -> {"#{value}-#{k}", v} end)
    |> Enum.into(%{})
  end

  def build_encryption_headers("AES256") do
    %{"x-amz-server-side-encryption" => "AES256"}
  end
  def build_encryption_headers([aws_kms_key_id: key_id]) do
    %{
      "x-amz-server-side-encryption" => "aws:kms",
      "x-amz-server-side-encryption-aws-kms-key-id" => key_id
    }
  end
  def build_encryption_headers(headers) do
    headers
    |> Stream.map(fn {k ,v} -> {normalize_param(k), v} end)
    |> namespace("x-amz-server-side-encryption")
  end
  def build_encryption_headers(val), do: val
end
