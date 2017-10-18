defmodule ExAws.PollyTest do
  use ExUnit.Case, async: true
  alias ExAws.{Polly, Operation}

  @version "v1"

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
      %Operation.JSON{stream_builder: nil,
                      http_method: :get,
                      parser: nil,
                      path: "/#{@version}/voices",
                      data: %{},
                      headers: [],
                      service: :polly,
                      before_request: nil}
    assert expected == Polly.describe_voices
  end

  test "#get_lexicon" do
    expected =
      %Operation.JSON{stream_builder: nil,
                      http_method: :get,
                      parser: nil,
                      path: "/#{@version}/lexicons/necronomicon",
                      data: %{},
                      headers: [],
                      service: :polly,
                      before_request: nil}
    assert expected == Polly.get_lexicon("necronomicon")
  end

  test "#list_lexicons" do
    expected =
      %Operation.JSON{stream_builder: nil,
                      http_method: :get,
                      parser: nil,
                      path: "/#{@version}/lexicons",
                      data: %{},
                      headers: [],
                      service: :polly,
                      before_request: nil}
    assert expected == Polly.list_lexicons
  end

  test "#put_lexicon" do
    expected =
      %Operation.JSON{stream_builder: nil,
                      http_method: :put,
                      parser: nil,
                      path: "/#{@version}/lexicons/necronomicon",
                      data: %{"Content" => @lexicon_content},
                      headers: [],
                      service: :polly,
                      before_request: nil}
    assert expected == Polly.put_lexicon("necronomicon", @lexicon_content)
  end

  test "#delete_lexicon" do
    expected =
      %Operation.JSON{stream_builder: nil,
                      http_method: :delete,
                      parser: nil,
                      path: "/#{@version}/lexicons/necronomicon",
                      data: %{},
                      headers: [],
                      service: :polly,
                      before_request: nil}
    assert expected == Polly.delete_lexicon("necronomicon")
  end

  test "#synthesize_speech" do
    %Operation.JSON{stream_builder: nil,
                    http_method: :post,
                    parser: parser,
                    path: "/#{@version}/speech",
                    data: %{"OutputFormat" => "mp3",
                            "Text" => "this is my boomstick",
                            "VoiceId" => "Joey"},
                    headers: [],
                    service: :polly,
                    before_request: nil} = Polly.synthesize_speech("this is my boomstick", "Joey", "mp3")
    assert is_function(parser)
  end
end
