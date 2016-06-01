defmodule ExAws.InstanceMeta do
  @meta_path_root "http://169.254.169.254/latest/meta-data/"

  def request(config, path) do
    case config.http_client.request(:get, @meta_path_root <> path) do
      {:ok, %{body: body}} -> body
    end
  end

  def role(config) do
    ExAws.InstanceMeta.request(config, "/iam/security-credentials/")
  end

  def security_credentials(config) do
    result = ExAws.InstanceMeta.request(config, "/iam/security-credentials/#{role(config)}")
    |> config.json_codec.decode!

    %{
      access_key_id: result["AccessKeyId"],
      secret_access_key: result["SecretAccessKey"],
      security_token: result["Token"],
      expiration: result["Expiration"]
    }
  end
end
