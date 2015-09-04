defmodule ExAws.CodeCommit.Core do
  @actions [
    "BatchGetRepositories",
    "CreateBranch",
    "CreateRepository",
    "DeleteRepository",
    "GetBranch",
    "GetRepository",
    "ListBranches",
    "ListRepositories",
    "UpdateDefaultBranch",
    "UpdateRepositoryDescription",
    "UpdateRepositoryName"]


  @doc """
  BatchGetRepositories

  Gets information about one or more repositories.

  Note:The description field for a repository accepts all HTML characters and
  all valid Unicode characters. Applications that do not HTML-encode the
  description and display it in a web page could expose users to potentially
  malicious code. Make sure that you HTML-encode the description field in any
  application that uses this API to display the repository description on a
  web page.
  """
  def batch_get_repositories(client, input) do
    request(client, "BatchGetRepositories", input)
  end

  @doc """
  CreateBranch

  Creates a new branch in a repository and points the branch to a commit.

  Note:Calling the create branch operation does not set a repository's
  default branch. To do this, call the update default branch operation.
  """
  def create_branch(client, input) do
    request(client, "CreateBranch", input)
  end

  @doc """
  CreateRepository

  Creates a new, empty repository.
  """
  def create_repository(client, input) do
    request(client, "CreateRepository", input)
  end

  @doc """
  DeleteRepository

  Deletes a repository. If a specified repository was already deleted, a null
  repository ID will be returned.

  <important>Deleting a repository also deletes all associated objects and
  metadata. After a repository is deleted, all future push calls to the
  deleted repository will fail.</important>
  """
  def delete_repository(client, input) do
    request(client, "DeleteRepository", input)
  end

  @doc """
  GetBranch

  Retrieves information about a repository branch, including its name and the
  last commit ID.
  """
  def get_branch(client, input) do
    request(client, "GetBranch", input)
  end

  @doc """
  GetRepository

  Gets information about a repository.

  Note:The description field for a repository accepts all HTML characters and
  all valid Unicode characters. Applications that do not HTML-encode the
  description and display it in a web page could expose users to potentially
  malicious code. Make sure that you HTML-encode the description field in any
  application that uses this API to display the repository description on a
  web page.
  """
  def get_repository(client, input) do
    request(client, "GetRepository", input)
  end

  @doc """
  ListBranches

  Gets information about one or more branches in a repository.
  """
  def list_branches(client, input) do
    request(client, "ListBranches", input)
  end

  @doc """
  ListRepositories

  Gets information about one or more repositories.
  """
  def list_repositories(client, input) do
    request(client, "ListRepositories", input)
  end

  @doc """
  UpdateDefaultBranch

  Sets or changes the default branch name for the specified repository.

  Note:If you use this operation to change the default branch name to the
  current default branch name, a success message is returned even though the
  default branch did not change.
  """
  def update_default_branch(client, input) do
    request(client, "UpdateDefaultBranch", input)
  end

  @doc """
  UpdateRepositoryDescription

  Sets or changes the comment or description for a repository.

  Note:The description field for a repository accepts all HTML characters and
  all valid Unicode characters. Applications that do not HTML-encode the
  description and display it in a web page could expose users to potentially
  malicious code. Make sure that you HTML-encode the description field in any
  application that uses this API to display the repository description on a
  web page.
  """
  def update_repository_description(client, input) do
    request(client, "UpdateRepositoryDescription", input)
  end

  @doc """
  UpdateRepositoryName

  Renames a repository.
  """
  def update_repository_name(client, input) do
    request(client, "UpdateRepositoryName", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
