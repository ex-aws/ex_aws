defmodule ExAws.Utils do
  @moduledoc false

  def identity(x), do: x

  def identity(x, _), do: x

  # This isn't tail recursive. However, given that the structures
  # being worked upon are relatively shallow, this is ok.
  def camelize_keys(opts, kwargs \\ []) do
    deep = kwargs[:deep] || false
    spec = kwargs[:spec] || %{}
    do_cmlz_keys(opts, deep: deep, spec: spec)
  end

  defp do_cmlz_keys([%{} | _] = opts, deep: deep, spec: spec) do
    Enum.map(opts, &do_cmlz_keys(&1, deep: deep, spec: spec))
  end

  defp do_cmlz_keys(opts = %{}, deep: deep, spec: spec) do
    opts
    |> Enum.reduce(%{}, fn {k, v}, map ->
      if deep do
        Map.put(map, camelize_key(k, spec: spec), do_cmlz_keys(v, deep: true, spec: spec))
      else
        Map.put(map, camelize_key(k, spec: spec), v)
      end
    end)
  end

  defp do_cmlz_keys(opts, kwargs) do
    try do
      opts |> Map.new() |> do_cmlz_keys(kwargs)
    rescue
      [Protocol.UndefinedError, ArgumentError, FunctionClauseError] -> opts
    end
  end

  def camelize_key(key, [spec: spec] \\ [spec: %{}]) do
    spec[key] || key |> maybe_stringify |> camelize
  end

  def camelize(string) do
    string
    |> to_charlist
    |> Enum.reduce({true, ''}, fn
      ?_, {_, acc} -> {true, acc}
      ?/, {_, acc} -> {false, [?. | acc]}
      char, {false, acc} -> {false, [char | acc]}
      char, {true, acc} -> {false, [upcase(char) | acc]}
    end)
    # charlist
    |> elem(1)
    # unreverses charlist after reducing
    |> Enum.reverse()
    |> to_string
  end

  def upcase(value) when is_atom(value), do: value |> Atom.to_string() |> String.upcase()
  def upcase(value) when is_binary(value), do: String.upcase(value)
  def upcase(char), do: :string.to_upper(char)

  def uuid, do: DateTime.utc_now() |> :erlang.phash2()

  def rename_keys(params, mapping) do
    mapping = Map.new(mapping)

    Enum.map(params, fn {k, v} ->
      {Map.get(mapping, k, k), v}
    end)
  end

  def format(params, kwargs \\ []) do
    prefix = kwargs[:prefix] || ""
    spec = kwargs[:spec] || %{}

    case kwargs[:type] || :xml do
      :xml ->
        xml_format(params, prefix: prefix, spec: spec)
        # :json -> json_format(params, prefix: prefix, spec: spec)
    end
  end

  # NOTE: xml_format is not tail call optimized
  # but it is unlikely that any AWS params will ever
  # be nested enough for this to  cause a stack overflow

  # Indexed formats

  defp xml_format([nested | _] = params, kwargs) when is_map(nested) do
    params |> Enum.map(&Map.to_list/1) |> xml_format(kwargs)
  end

  defp xml_format([nested | _] = params, prefix: pre, spec: spec) when is_list(nested) do
    params
    |> Stream.with_index(1)
    |> Stream.map(fn {params, i} -> {params, Integer.to_string(i)} end)
    |> Stream.flat_map(fn {params, i} ->
      xml_format(params, prefix: pre <> dot?(pre) <> i, spec: spec)
    end)
    |> Enum.to_list()
  end

  defp xml_format([param | _] = params, prefix: pre, spec: spec) when is_tuple(param) do
    params
    |> Stream.map(fn {key, values} -> {maybe_camelize(key, spec: spec), values} end)
    |> Stream.flat_map(fn {key, values} ->
      xml_format(values, prefix: pre <> dot?(pre) <> key, spec: spec)
    end)
    |> Enum.to_list()
  end

  # Non-indexed formats
  defp xml_format(params, kwargs) when is_list(params) do
    pre = kwargs[:prefix]

    params
    |> Stream.with_index(1)
    |> Stream.map(fn {value, i} -> {value, Integer.to_string(i)} end)
    |> Stream.map(fn {value, i} -> {pre <> dot?(pre) <> i, value} end)
    |> Enum.to_list()
  end

  defp xml_format(params, kwargs) when is_map(params) do
    xml_format(Map.to_list(params), kwargs)
  end

  defp xml_format(value, kwargs), do: [{kwargs[:prefix], value}]

  defp dot?(""), do: ""
  defp dot?(_), do: "."

  def filter_nil_params(opts) do
    opts
    |> Enum.reject(fn {_key, value} -> value == nil end)
    |> Enum.into(%{})
  end

  def maybe_camelize(elem, kwargs \\ [spec: %{}])
  def maybe_camelize(elem, kwargs) when is_atom(elem), do: camelize_key(elem, kwargs)
  def maybe_camelize(elem, _) when is_bitstring(elem), do: elem

  def maybe_stringify(elem) when is_atom(elem), do: Atom.to_string(elem)
  def maybe_stringify(elem) when is_bitstring(elem), do: elem

  defmacro __using__(kwargs) do
    camelize_inject =
      quote do
        [spec: unquote(kwargs[:non_standard_keys] || %{})] ++ kwargs
      end

    format_inject =
      quote do
        [type: unquote(kwargs[:format_type] || :xml)] ++ unquote(camelize_inject)
      end

    quote do
      import ExAws.Utils,
        except: [
          format: 2,
          format: 1,
          camelize_keys: 2,
          camelize_keys: 1,
          camelize_key: 2,
          camelize_key: 1,
          maybe_camelize: 2,
          maybe_camelize: 1
        ]

      defp format(params, kwargs \\ []), do: ExAws.Utils.format(params, unquote(format_inject))

      defp camelize_keys(opts, kwargs \\ []),
        do: ExAws.Utils.camelize_keys(opts, unquote(camelize_inject))

      defp camelize_key(opts, kwargs \\ []),
        do: ExAws.Utils.camelize_key(opts, unquote(camelize_inject))

      defp maybe_camelize(opts, kwargs \\ []),
        do: ExAws.Utils.maybe_camelize(opts, unquote(camelize_inject))
    end
  end
end
