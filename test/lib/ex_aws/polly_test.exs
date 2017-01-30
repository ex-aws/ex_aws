defmodule ExAws.PollyTest do
  use ExUnit.Case, async: true
  alias ExAws.{Polly, Operation}

  @doc """
  W3C PLS-compliant lexicon from:
  http://docs.aws.amazon.com/polly/latest/dg/gs-put-lexicon.html#gs-put-lexicon-example-1
  """
  @lexicon_content """
  <?xml version="1.0" encoding="UTF-8"?>
  <lexicon version="1.0"
        xmlns="http://www.w3.org/2005/01/pronunciation-lexicon"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.w3.org/2005/01/pronunciation-lexicon
          http://www.w3.org/TR/2007/CR-pronunciation-lexicon-20071212/pls.xsd"
        alphabet="ipa"
        xml:lang="en-US">
    <lexeme>
      <grapheme>W3C</grapheme>
      <alias>World Wide Web Consortium</alias>
    </lexeme>
  </lexicon>
  """

  test "#describe_voices" do
    expected =
      %Operation.Polly{body: "",
                       headers: %{},
                       http_method: :get,
                       lexicon_name: "",
                       params: %{},
                       parser: &ExAws.Polly.Parsers.parse_describe_voices/2,
                       path: "/",
                       resource: "voices",
                       service: :polly,
                       stream_builder: nil,
                       version: "v1"}
    assert expected == Polly.describe_voices
  end

  test "#get_lexicon" do
    expected =
      %Operation.Polly{body: "",
                       headers: %{},
                       http_method: :get,
                       lexicon_name: "necronomicon",
                       params: %{},
                       parser: &ExAws.Polly.Parsers.parse_get_lexicon/2,
                       path: "/",
                       resource: "lexicons",
                       service: :polly,
                       stream_builder: nil,
                       version: "v1"}
    assert expected == Polly.get_lexicon("necronomicon")
  end

  test "#list_lexicons" do
    expected =
      %Operation.Polly{body: "",
                       headers: %{},
                       http_method: :get,
                       lexicon_name: "",
                       params: %{},
                       parser: &ExAws.Polly.Parsers.parse_list_lexicons/2,
                       path: "/",
                       resource: "lexicons",
                       service: :polly,
                       stream_builder: nil,
                       version: "v1"}
    assert expected == Polly.list_lexicons
  end

  test "#put_lexicon" do
    params = %{Content: @lexicon_content}
    expected =
      %Operation.Polly{body: "",
                       headers: %{},
                       http_method: :put,
                       lexicon_name: "necronomicon",
                       params: params,
                       parser: &ExAws.Polly.Parsers.parse_put_lexicon/2,
                       path: "/",
                       resource: "lexicons",
                       service: :polly,
                       stream_builder: nil,
                       version: "v1"}
    assert expected == Polly.put_lexicon("necronomicon", params)
  end

  test "#delete_lexicon" do
    expected =
      %Operation.Polly{body: "",
                       headers: %{},
                       http_method: :delete,
                       lexicon_name: "necronomicon",
                       params: %{},
                       parser: &ExAws.Polly.Parsers.parse_delete_lexicon/2,
                       path: "/",
                       resource: "lexicons",
                       service: :polly,
                       stream_builder: nil,
                       version: "v1"}
    assert expected == Polly.delete_lexicon("necronomicon")
  end

  test "#synthesize_speech" do
    params =
      %{Text: "Hello world.",
        OutputFormat: "mp3",
        VoiceId: "Joey"}
    expected =
      %Operation.Polly{body: "",
                       headers: %{},
                       http_method: :post,
                       lexicon_name: "",
                       params: params,
                       parser: &ExAws.Polly.Parsers.parse_synthesize_speech/2,
                       path: "/",
                       resource: "speech",
                       service: :polly,
                       stream_builder: nil,
                       version: "v1"}
    assert expected == Polly.synthesize_speech(params)
  end
end
