defmodule ExAws.S3.Utils do
  ## Formatting and helpers
  @moduledoc false

  @headers [:cache_control, :content_disposition, :content_encoding, :content_length, :content_type,
    :expect, :expires]
  @amz_headers [:storage_class, :website_redirect_location]
  def put_object_headers(opts) do
    opts = opts |> Enum.into(%{})

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
    |> Enum.into(%{})
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

  def build_notification_config(sections) do
    properties = Enum.map(sections, &build_notification_config_section/1)
    ["<NotificationConfiguration>", properties, "</NotificationConfiguration>"]
    |> IO.iodata_to_binary
  end

  def build_notification_config_section(config) do
    types = [
      topic: "TopicConfiguration",
      queue: "QueueConfiguration",
      cloud_function: "CloudFunctionConfiguration"
    ]
    arn = [
      topic: "Topic",
      queue: "Queue",
      cloud_function: "CloudFunction"
    ]
    ["<#{types[config.type]}>",
     "<Id>", config.id, "</Id>",
     build_notification_config_filter(config[:filter]),
     "<#{arn[config.type]}>", config.arn, "</#{arn[config.type]}>",
     Enum.map(config.events, &("<Event>#{&1}</Event>")),
     "</#{types[config.type]}>"]
  end

  def build_notification_config_filter([]), do: []
  def build_notification_config_filter(nil), do: []
  def build_notification_config_filter(rules) do
    ["<Filter><S3Key>",
     Enum.map(rules, fn {n, v} ->
       "<FilterRule><Name>#{n}</Name><Value>#{v}</Value></FilterRule>"
     end),
     "</S3Key></Filter>"]
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
    |> Enum.map(fn {k ,v} -> {normalize_param(k), v} end)
    |> namespace("x-amz-server-side-encryption")
  end
end
