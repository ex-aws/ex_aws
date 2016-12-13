defprotocol ExAws.CloudFront.Policy do
  @doc """
  Create a Signed URL Using a Policy.
  """
  def get_signed_url(policy, keypair_id, private_key)

  @doc """
  Create a Policy Statement for a Signed URL That Uses a Policy.
  """
  def to_statement(policy)
end
