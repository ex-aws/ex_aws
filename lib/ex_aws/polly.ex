defmodule ExAws.Polly do
  @moduledoc """
  Operations on AWS Polly

  http://docs.aws.amazon.com/polly/latest/dg/API_Reference.html
  """

  import ExAws.Utils, only: [camelize_keys: 1]

  @version "v1"

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
        path: "/#{@version}/voices"}
    data = camelize_keys(opts)
    request(data, request_opts)
  end

  ## Lexicons
  #############

  @doc "Get lexicon"
  @spec get_lexicon(lexicon_name :: binary) :: ExAws.Operation.JSON.t
  def get_lexicon(lexicon_name) do
    request_opts =
      %{http_method: :get,
        path: "/#{@version}/lexicons/#{lexicon_name}"}
    request(%{}, request_opts)
  end

  @doc "Get lexicons"
  @spec list_lexicons() :: ExAws.Operation.JSON.t
  @spec list_lexicons(opts :: list_lexicons_opts) :: ExAws.Operation.JSON.t
  def list_lexicons(opts \\ []) do
    request_opts =
      %{http_method: :get,
        path: "/#{@version}/lexicons"}
    data = camelize_keys(opts)
    request(data, request_opts)
  end

  @doc "Put lexicon"
  @spec put_lexicon(lexicon_name :: binary, content :: binary) :: ExAws.Operation.JSON.t
  def put_lexicon(lexicon_name, content) do
    request_opts =
      %{http_method: :put,
        path: "/#{@version}/lexicons/#{lexicon_name}"}
    data = %{"Content" => content}
    request(data, request_opts)
  end

  @doc "Delete lexicon"
  @spec delete_lexicon(lexicon_name :: binary) :: ExAws.Operation.JSON.t
  def delete_lexicon(lexicon_name) do
    request_opts =
      %{http_method: :delete,
        path: "/#{@version}/lexicons/#{lexicon_name}"}
    request(%{}, request_opts)
  end

  ## Speech
  #############

  @doc "Synthesize speech"
  @spec synthesize_speech(text :: binary, voice_id :: binary, output_format :: binary) :: ExAws.Operation.JSON.t
  @spec synthesize_speech(text :: binary, voice_id :: binary, output_format :: binary, opts :: synthesize_speech_opts) :: ExAws.Operation.JSON.t
  def synthesize_speech(text, voice_id, output_format, opts \\ []) do
    parser =
      fn
        {:error, reason}, _config -> {:error, reason}
        {:ok, %{body: body, headers: headers}}, _config ->
          %{"AudioStream" => body,
            "ContentType" => List.keyfind(headers, "Content-Type", 0) |> elem(1),
            "RequestCharacters" => List.keyfind(headers, "x-amzn-RequestCharacters", 0) |> elem(1)}
      end
    request_opts =
      %{http_method: :post,
        path: "/#{@version}/speech",
        parser: parser}
    required_data =
      %{"Text" => text,
        "VoiceId" => voice_id,
        "OutputFormat" => output_format}
    data =
      opts
      |> camelize_keys()
      |> Map.merge(required_data)
    request(data, request_opts)
  end

  defp request(data, opts) do
    default_opts =
      %{data: data,
        headers: []}
    opts = Map.merge(default_opts, opts)
    ExAws.Operation.JSON.new(:polly, opts)
  end
end
