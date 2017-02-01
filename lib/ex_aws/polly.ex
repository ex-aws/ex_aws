defmodule ExAws.Polly do
  @moduledoc """
  Operations on AWS Polly

  http://docs.aws.amazon.com/polly/latest/dg/API_Reference.html
  """

  import ExAws.Utils, only: [camelize_keys: 1, identity: 2]

  @namespace "Polly_20160610"

  @type describe_voices_opts :: [
    {:langauge_code, binary} |
    {:next_token, binary}]

  @type list_lexicons_opts :: [{:next_token, binary}]

  @type synthesize_speech_opts :: [
    {:lexicon_names, [binary]},
    {:sample_rate, binary},
    {:text_type, binary}]

  ## Voices
  #############

  @doc "Describe voices"
  @spec describe_voices(opts :: describe_voices_opts) :: ExAws.Operation.JSON.t
  def describe_voices(opts \\ []) do
    request_opts =
      %{http_method: :get,
        path: "/v1/voices"}
    request(:describe_voices, camelize_keys(opts), request_opts)
  end

  ## Lexicons
  #############

  @doc "Get lexicon"
  @spec get_lexicon(lexicon_name :: binary) :: ExAws.Operation.JSON.t
  def get_lexicon(lexicon_name) do
    request_opts =
      %{http_method: :get,
        path: "/v1/lexicons/#{lexicon_name}"}
    request(:get_lexicon, %{}, request_opts)
  end

  @doc "Get lexicons"
  @spec list_lexicons() :: ExAws.Operation.JSON.t
  @spec list_lexicons(opts :: list_lexicons_opts) :: ExAws.Operation.JSON.t
  def list_lexicons(opts \\ []) do
    request_opts =
      %{http_method: :get,
        path: "/v1/lexicons"}
    request(:list_lexicons, camelize_keys(opts), request_opts)
  end

  @doc "Put lexicon"
  @spec put_lexicon(lexicon_name :: binary, content :: binary) :: ExAws.Operation.JSON.t
  def put_lexicon(lexicon_name, content) do
    request_opts =
      %{http_method: :put,
        path: "/v1/lexicons/#{lexicon_name}"}
    opts = %{"Content" => content}
    request(:put_lexicon, opts, request_opts)
  end

  @doc "Delete lexicon"
  @spec delete_lexicon(lexicon_name :: binary) :: ExAws.Operation.JSON.t
  def delete_lexicon(lexicon_name) do
    request_opts =
      %{http_method: :delete,
        path: "/v1/lexicons/#{lexicon_name}"}
    request(:delete_lexicon, %{}, request_opts)
  end

  ## Speech
  #############

  @doc "Synthesize speech"
  @spec synthesize_speech(text :: binary, voice_id :: binary, output_format :: binary) :: ExAws.Operation.JSON.t
  @spec synthesize_speech(text :: binary, voice_id :: binary, output_format :: binary, opts :: synthesize_speech_opts) :: ExAws.Operation.JSON.t
  def synthesize_speech(text, voice_id, output_format, opts \\ []) do
    request_opts =
      %{http_method: :post,
        path: "/v1/speech",
        parser: &identity/2}
    opts =
      opts
      |> camelize_keys()
      |> Map.merge(%{
           "Text" => text,
           "VoiceId" => voice_id,
           "OutputFormat" => output_format})
    request(:synthesize_speech, opts, request_opts)
  end

  defp request(action, data, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize
    default_opts =
      %{data: data,
        headers: []}
    ExAws.Operation.JSON.new(:polly, Map.merge(default_opts, opts))
  end
end
