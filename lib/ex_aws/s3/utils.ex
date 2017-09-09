defmodule ExAws.S3.Utils do
  ## Formatting and helpers
  @moduledoc false

  def ensure_slash("/" <> _ = path), do: path
  def ensure_slash(path), do:  "/" <> path

  @headers [:cache_control, :content_disposition, :content_encoding, :content_length, :content_type,
    :expect, :expires, :content_md5]
  @amz_headers [:storage_class, :website_redirect_location]
  def put_object_headers(opts) do
    opts = opts |> Map.new

    regular_headers = opts
    |> format_and_take(@headers)

    amz_headers = opts
    |> format_and_take(@amz_headers)
    |> namespace("x-amz")

    acl_headers = format_acl_headers(opts)

    encryption_headers = opts
    |> Map.get(:encryption, %{})
    |> build_encryption_headers

    meta = opts
    |> Map.get(:meta, [])
    |> build_meta_headers

    regular_headers
    |> Map.merge(amz_headers)
    |> Map.merge(acl_headers)
    |> Map.merge(encryption_headers)
    |> Map.merge(meta)
  end

  def build_meta_headers(meta) do
    Enum.into(meta, %{}, fn {k ,v} ->
      {"x-amz-meta-#{k}", v}
    end)
  end

  @doc """
  format_and_take %{param_one: "v1", param_two: "v2"}, [:param_one]
  #=> %{"param-one" => "v1"}
  """
  def format_and_take(%{} = opts, param_list) do
    param_list
    |> Enum.map(&{&1, normalize_param(&1)})
    |> Enum.reduce(%{}, fn({elixir_opt, aws_opt}, params) ->
      case Map.fetch(opts, elixir_opt) do
        :error       -> params
        {:ok, nil}   -> params
        {:ok, value} -> Map.put(params, aws_opt, value)
      end
    end)
  end

  def format_and_take(opts, param_list) do
    opts
    |> Map.new
    |> format_and_take(param_list)
  end

  @acl_headers [:acl, :grant_read, :grant_write, :grant_read_acp, :grant_write_acp, :grant_full_control]
  def format_acl_headers(%{acl: canned_acl}) do
    %{"x-amz-acl" => normalize_param(canned_acl)}
  end
  def format_acl_headers(grants), do: format_grant_headers(grants)

  def format_grant_headers(grants) do
    grants
    |> format_and_take(@acl_headers)
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

    properties = case Map.fetch(rule, :max_age_seconds) do
      :error       -> properties
      {:ok, nil}   -> properties
      {:ok, value} -> ["<MaxAgeSeconds>#{value}</MaxAgeSeconds>" | properties]
    end

    ["<CORSRule>", properties, "</CORSRule>"]
    |> IO.iodata_to_binary
  end

  def normalize_param(param) when is_atom(param) do
    param
    |> Atom.to_string
    |> String.replace("_", "-")
  end
  def normalize_param(other), do: other

  def namespace(list, value) do
    list
    |> Enum.map(fn {k ,v} -> {"#{value}-#{k}", v} end)
    |> Map.new
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
    |> Enum.map(fn {k ,v} -> {normalize_param(k), v} end)
    |> namespace("x-amz-server-side-encryption")
  end

  # If we're using a standard port such as 80 or 443, then it needs to be excluded from the signed
  # headers. Including standard ports will cause AWS's signature validation to fail with a
  # SignatureDoesNotMatch error.
  @excluded_ports [80, "80", 443, "443"]
  def sanitized_port_component(%{port: nil}), do: ""
  def sanitized_port_component(%{port: port}) when port in @excluded_ports, do: ""
  def sanitized_port_component(%{port: port}), do: ":#{port}"
  def sanitized_port_component(_), do: ""
end
