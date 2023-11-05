defmodule ExAws.EventStream do
  # https://docs.aws.amazon.com/AmazonS3/latest/API/API_SelectObjectContent.html
  # https://docs.aws.amazon.com/AmazonS3/latest/API/RESTSelectObjectAppendix.html

  alias ExAws.EventStream.Message

  def parse_message(chunk) do
    with {:ok, message} <- Message.parse(chunk) do
      message
    end
  end
end
