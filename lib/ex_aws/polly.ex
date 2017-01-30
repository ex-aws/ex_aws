defmodule ExAws.Polly do
  @moduledoc """
  Operations on AWS Polly

  http://docs.aws.amazon.com/polly/latest/dg/API_Reference.html
  """

  ## Voices
  #############

  @doc "Describe voices"
  @spec describe_voices(Map.t) :: ExAws.Operation.Polly.t
  @spec describe_voices(Map.t, opts :: Keyword.t) :: ExAws.Operation.Polly.t
  def describe_voices(params \\ %{}, opts \\ %{}) do
    data =
      [http_method: :get,
       parser: Map.get(opts, :parser, &ExAws.Polly.Parsers.parse_describe_voices/2),
       resource: "voices",
       params: params]
    request(data, opts)
  end

  ## Lexicons
  #############

  @doc "Get lexicon"
  @spec get_lexicon(String.t) :: ExAws.Operation.Polly.t
  @spec get_lexicon(String.t, opts :: Keyword.t) :: ExAws.Operation.Polly.t
  def get_lexicon(lexicon_name, opts \\ %{}) do
    data =
      [http_method: :get,
       parser: Map.get(opts, :parser, &ExAws.Polly.Parsers.parse_get_lexicon/2),
       resource: "lexicons",
       lexicon_name: lexicon_name,
       params: %{}]
    request(data, opts)
  end

  @doc "Get lexicons"
  @spec list_lexicons() :: ExAws.Operation.Polly.t
  @spec list_lexicons(Map.t) :: ExAws.Operation.Polly.t
  @spec list_lexicons(Map.t, opts :: Keyword.t) :: ExAws.Operation.Polly.t
  def list_lexicons(params \\ %{}, opts \\ %{}) do
    data =
      [http_method: :get,
       parser: Map.get(opts, :parser, &ExAws.Polly.Parsers.parse_list_lexicons/2),
       resource: "lexicons",
       params: params]
    request(data, opts)
  end

  @doc "Put lexicon"
  @spec put_lexicon(String.t, Map.t) :: ExAws.Operation.Polly.t
  @spec put_lexicon(String.t, Map.t, opts :: Keyword.t) :: ExAws.Operation.Polly.t
  def put_lexicon(lexicon_name, params, opts \\ %{}) do
    data =
      [http_method: :put,
       parser: Map.get(opts, :parser, &ExAws.Polly.Parsers.parse_put_lexicon/2),
       resource: "lexicons",
       lexicon_name: lexicon_name,
       params: params]
    request(data, opts)
  end

  @doc "Delete lexicon"
  @spec delete_lexicon(String.t) :: ExAws.Operation.Polly.t
  @spec delete_lexicon(String.t, opts :: Keyword.t) :: ExAws.Operation.Polly.t
  def delete_lexicon(lexicon_name, opts \\ %{}) do
    data =
      [http_method: :delete,
       parser: Map.get(opts, :parser, &ExAws.Polly.Parsers.parse_delete_lexicon/2),
       resource: "lexicons",
       lexicon_name: lexicon_name,
       params: %{}]
    request(data, opts)
  end

  ## Speech
  #############

  @doc "Synthesize speech"
  @spec synthesize_speech(Map.t) :: ExAws.Operation.Polly.t
  @spec synthesize_speech(Map.t, opts :: Keyword.t) :: ExAws.Operation.Polly.t
  def synthesize_speech(params, opts \\ %{}) do
    data =
      [http_method: :post,
       parser: Map.get(opts, :parser, &ExAws.Polly.Parsers.parse_synthesize_speech/2),
       resource: "speech",
       params: params]
    request(data, opts)
  end

  defp request(data, opts) do
    %ExAws.Operation.Polly{
      http_method: data[:http_method] || nil,
      parser: data[:parser] || nil,
      body: data[:body] || "",
      headers: data[:headers] || %{},
      version: data[:version] || "v1",
      resource: data[:resource] || "",
      lexicon_name: data[:lexicon_name] || "",
      params: data[:params] || %{}
    } |> struct(opts)
  end
end
