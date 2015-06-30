defmodule ExAws.S3.Utils do
  ## Formatting and helpers
  def format_and_take(%{} = opts, param_list) do
    param_list
    |> Enum.map(&normalize_param/1)
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
    aws_param = param
    |> Atom.to_string
    |> String.replace("_", "-")

    {param, aws_param}
  end
  def normalize_param(other), do: other

  def namespace(list, value) do
    list
    |> Stream.map(fn {k ,v} -> {"#{value}-#{k}", v} end)
    |> Enum.into(%{})
  end
end
