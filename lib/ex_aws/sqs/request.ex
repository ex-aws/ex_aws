defmodule ExAws.SQS.Request do
  @moduledoc false

  def request(client, queue_name, action, params \\ []) do
    {_, http_method} = ExAws.SQS.Impl |> ExAws.Actions.get(action)

    headers = [
      {"content-type", "application/x-www-form-urlencoded"},
    ]

    ExAws.Request.request(http_method, client.config |> url(queue_name, params), [], headers, client)
    |> parse(client.config)
  end

  def parse({:error, result}, _), do: {:error, result}
  def parse({:ok, body}, config) do
    case config[:json_codec].decode(body) do
      {:ok, result} -> {:ok, result}
      {:error, _} -> {:error, body}
    end
  end

  def url(config, queue_name, params) do
    # https://sqs.[region].amazonaws.com/[account_id]/[queue_name]?
    # Action=[action]&  
    ""
  end
end
