defmodule ExAws.ParsersTest.Dummy.Parsers do
  use ExAws.Parsers
end

defmodule ExAws.ParsersTest do
  use ExUnit.Case, async: true
  import Support.ParserHelpers
  alias ExAws.ParsersTest.Dummy.Parsers

  test "it should handle parsing an error" do
    rsp = """
    <?xml version=\"1.0\"?>
    <ErrorResponse xmlns=\"http://queue.amazonaws.com/doc/2012-11-05/\">
      <Error>
        <Type>Sender</Type>
        <Code>ExpiredToken</Code>
        <Message>The security token included in the request is expired</Message>
        <Detail/>
      </Error>
      <RequestId>f7ac5905-2fb6-5529-a86d-09628dae67f4</RequestId>
    </ErrorResponse>
    """
    |> to_error

    {:error, {:http_error, 403, err}} = Parsers.parse(rsp, :set_endpoint_attributes)

    assert "f7ac5905-2fb6-5529-a86d-09628dae67f4" == err[:request_id]
    assert "Sender" == err[:type]
    assert "ExpiredToken" == err[:code]
    assert "The security token included in the request is expired" == err[:message]
  end
end
