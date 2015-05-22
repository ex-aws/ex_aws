defmodule ExAws.InstanceMeta do
  @meta_path_root "http://169.254.169.254/latest/meta-data/"

  def request(%{config: config}, path) do
    case config.http_client.request(:get, @meta_path_root <> path) do
      {:ok, %{body: body}} -> body
    end
  end

  def role(client) do
    ExAws.InstanceMeta.request(client, "/iam/security-credentials/")
  end

  def security_credentials(%{config: config} = client) do
    result = ExAws.InstanceMeta.request(client, "/iam/security-credentials/#{role(client)}")
    |> config.json_codec.decode!

    %{
      access_key_id: result["AccessKeyId"],
      secret_access_key: result["SecretAccessKey"],
      expiration: result["Expiration"]
    }
  end
end
