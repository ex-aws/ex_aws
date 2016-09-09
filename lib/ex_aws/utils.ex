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

  def iso_z_to_secs(<<date::binary-10, "T", time::binary-8, "Z">>) do
    <<year::binary-4, "-", mon::binary-2, "-", day::binary-2>> = date
    <<hour::binary-2, ":", min::binary-2, ":", sec::binary-2>> = time
    year = year |> String.to_integer
    mon  = mon  |> String.to_integer
    day  = day  |> String.to_integer
    hour = hour |> String.to_integer
    min  = min  |> String.to_integer
    sec  = sec  |> String.to_integer

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

  def add_seconds(datetime, seconds_to_add) do
    datetime
    |> :calendar.datetime_to_gregorian_seconds()
    |> Kernel.+(seconds_to_add)
    |> :calendar.gregorian_seconds_to_datetime()
  end
end
