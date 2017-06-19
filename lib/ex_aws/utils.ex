defmodule ExAws.Utils do
  @moduledoc false

  def identity(x), do: x

  def identity(x, _), do: x

  def camelize_keys(opts) do
    camelize_keys(opts, deep: false)
  end

  # This isn't tail recursive. However, given that the structures
  # being worked upon are relatively shallow, this is ok.
  def camelize_keys(opts = %{}, deep: deep) do
    opts |> Enum.reduce(%{}, fn({k ,v}, map) ->
      if deep do
        Map.put(map, camelize_key(k), camelize_keys(v, deep: true))
      else
        Map.put(map, camelize_key(k), v)
      end
    end)
  end

  def camelize_keys([%{} | _] = opts, deep: deep) do
    Enum.map(opts, &camelize_keys(&1, deep: deep))
  end

  def camelize_keys(opts, depth) do
    try do
      opts
      |> Map.new
      |> camelize_keys(depth)
    rescue
      [Protocol.UndefinedError, ArgumentError, FunctionClauseError] -> opts
    end
  end

  def camelize_key(key) when is_atom(key) do
    key
    |> Atom.to_string
    |> camelize
  end

  def camelize_key(key) when is_binary(key) do
    key |> camelize
  end

  def camelize(string)
  def camelize(""), do: ""
  def camelize(<<?_, t :: binary>>), do: camelize(t)
  def camelize(<<h, t :: binary>>),  do: <<to_upper_char(h)>> <> do_camelize(t)

  defp do_camelize(<<?_, ?_, t :: binary>>),
    do: do_camelize(<< ?_, t :: binary >>)
  defp do_camelize(<<?_, h, t :: binary>>) when h in ?a..?z,
    do: <<to_upper_char(h)>> <> do_camelize(t)
  defp do_camelize(<<?_>>),
    do: <<>>
  defp do_camelize(<<?/, t :: binary>>),
    do: <<?.>> <> camelize(t)
  defp do_camelize(<<h, t :: binary>>),
    do: <<h>> <> do_camelize(t)
  defp do_camelize(<<>>),
    do: <<>>

  defp to_upper_char(char) when char in ?a..?z, do: char - 32
  defp to_upper_char(char), do: char

  def upcase(value) when is_atom(value) do
    value
    |> Atom.to_string
    |> String.upcase
  end

  def upcase(value) when is_binary(value) do
    String.upcase(value)
  end

  @seconds_0_to_1970 :calendar.datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}})

  def iso_z_to_secs(<<date::binary-10, "T", time::binary-8, "Z">> <> _) do
    [year, mon, day] = date
      |> String.split("-") 
      |> Enum.map(&String.to_integer/1)

    [hour, min, sec] = time
      |> String.split(":") 
      |> Enum.map(&String.to_integer/1)

    # Seriously? Gregorian seconds but not epoch seconds?
    greg_secs = :calendar.datetime_to_gregorian_seconds({{year, mon, day}, {hour, min, sec}})
    greg_secs - @seconds_0_to_1970
  end

  def now_in_seconds do
    greg_secs = :os.timestamp
    |> :calendar.now_to_universal_time
    |> :calendar.datetime_to_gregorian_seconds

    greg_secs - @seconds_0_to_1970
  end

  def uuid, do: DateTime.utc_now |> :erlang.phash2

  def rename_keys(params, mapping) do
    mapping = Map.new(mapping)
    Enum.map(params, fn {k, v} ->
      {Map.get(mapping, k, k), v}
    end)
  end

  def build_indexed_params(key_template, values) when is_list(values) do
    case String.split(key_template, "{i}") do
      [prefix, suffix] -> 
        values
        |> Enum.with_index(1)
        |> Enum.map(fn {value, i} -> {prefix <> "#{i}" <> suffix, value} end)

      _ -> raise ArgumentError, "The Argument key_template is invalid. 
      Expected a string with exactly one location for an index, got: \"#{key_template}\"
      Example valid key_template: \"Tags.member.{i}.Key\""
    end
  end

  def build_indexed_params(key_template, value), do: build_indexed_params(key_template, [value])

  def build_indexed_params(key_templates) when is_list(key_templates) do
    Enum.flat_map(key_templates, fn {key_template, values} -> build_indexed_params(key_template, values) end)
  end

end
