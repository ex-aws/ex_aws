defmodule ExAws.Polly.Parsers do
  @moduledoc """
  Parsers for AWS Polly responses
  """

  ## Voices
  #############

  def parse_describe_voices({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end
  def parse_describe_voices(val, _config), do: val

  ## Lexicons
  #############

  def parse_get_lexicon({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end
  def parse_get_lexicon(val, _config), do: val

  def parse_list_lexicons({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end
  def parse_list_lexicons(val, _config), do: val

  def parse_put_lexicon({:ok, %{body: _body}}, _config) do
    :ok
  end
  def parse_put_lexicon(val, _config), do: val

  def parse_delete_lexicon({:ok, %{body: _body}}, _config) do
    :ok
  end
  def parse_delete_lexicon(val, _config), do: val

  ## Speech
  #############

  def parse_synthesize_speech({:ok, %{body: body}}, _config) do
    {:ok, body}
  end
  def parse_synthesize_speech(val, _config), do: val
end
