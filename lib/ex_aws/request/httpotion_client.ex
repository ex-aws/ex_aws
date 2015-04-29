defmodule ExAws.Request.HTTPotion do
  @behaviour ExAws.Request.HttpClient

  @moduledoc false

  def request(method, url, body, headers) do
    {:ok, HTTPotion.request(method, url, [body: body, headers: headers, ibrowse: [headers_as_is: true]])}
  end
end
