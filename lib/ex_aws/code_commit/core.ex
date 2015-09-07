defmodule ExAws.CodeCommit.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
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

  @moduledoc """
  ## AWS CodeCommit

  AWS CodeCommit

  This is the *AWS CodeCommit API Reference*. This reference provides
  descriptions of the AWS CodeCommit API.

  You can use the AWS CodeCommit API to work with the following objects:

  - Repositories

  - Branches

  - Commits

  For information about how to use AWS CodeCommit, see the *AWS CodeCommit
  User Guide*.
  """

  @type account_id :: binary

  @type arn :: binary

  @type batch_get_repositories_input :: [
    repository_names: repository_name_list,
  ]

  @type batch_get_repositories_output :: [
    repositories: repository_metadata_list,
    repositories_not_found: repository_not_found_list,
  ]

  @type branch_does_not_exist_exception :: [
  ]

  @type branch_info :: [
    branch_name: branch_name,
    commit_id: commit_id,
  ]

  @type branch_name :: binary

  @type branch_name_exists_exception :: [
  ]

  @type branch_name_list :: [branch_name]

  @type branch_name_required_exception :: [
  ]

  @type clone_url_http :: binary

  @type clone_url_ssh :: binary

  @type commit_does_not_exist_exception :: [
  ]

  @type commit_id :: binary

  @type commit_id_required_exception :: [
  ]

  @type create_branch_input :: [
    branch_name: branch_name,
    commit_id: commit_id,
    repository_name: repository_name,
  ]

  @type create_repository_input :: [
    repository_description: repository_description,
    repository_name: repository_name,
  ]

  @type create_repository_output :: [
    repository_metadata: repository_metadata,
  ]

  @type creation_date :: integer

  @type delete_repository_input :: [
    repository_name: repository_name,
  ]

  @type delete_repository_output :: [
    repository_id: repository_id,
  ]

  @type encryption_integrity_checks_failed_exception :: [
  ]

  @type encryption_key_access_denied_exception :: [
  ]

  @type encryption_key_disabled_exception :: [
  ]

  @type encryption_key_not_found_exception :: [
  ]

  @type encryption_key_unavailable_exception :: [
  ]

  @type get_branch_input :: [
    branch_name: branch_name,
    repository_name: repository_name,
  ]

  @type get_branch_output :: [
    branch: branch_info,
  ]

  @type get_repository_input :: [
    repository_name: repository_name,
  ]

  @type get_repository_output :: [
    repository_metadata: repository_metadata,
  ]

  @type invalid_branch_name_exception :: [
  ]

  @type invalid_commit_id_exception :: [
  ]

  @type invalid_continuation_token_exception :: [
  ]

  @type invalid_order_exception :: [
  ]

  @type invalid_repository_description_exception :: [
  ]

  @type invalid_repository_name_exception :: [
  ]

  @type invalid_sort_by_exception :: [
  ]

  @type last_modified_date :: integer

  @type list_branches_input :: [
    next_token: next_token,
    repository_name: repository_name,
  ]

  @type list_branches_output :: [
    branches: branch_name_list,
    next_token: next_token,
  ]

  @type list_repositories_input :: [
    next_token: next_token,
    order: order_enum,
    sort_by: sort_by_enum,
  ]

  @type list_repositories_output :: [
    next_token: next_token,
    repositories: repository_name_id_pair_list,
  ]

  @type maximum_repository_names_exceeded_exception :: [
  ]

  @type next_token :: binary

  @type order_enum :: binary

  @type repository_description :: binary

  @type repository_does_not_exist_exception :: [
  ]

  @type repository_id :: binary

  @type repository_limit_exceeded_exception :: [
  ]

  @type repository_metadata :: [
    arn: arn,
    account_id: account_id,
    clone_url_http: clone_url_http,
    clone_url_ssh: clone_url_ssh,
    creation_date: creation_date,
    default_branch: branch_name,
    last_modified_date: last_modified_date,
    repository_description: repository_description,
    repository_id: repository_id,
    repository_name: repository_name,
  ]

  @type repository_metadata_list :: [repository_metadata]

  @type repository_name :: binary

  @type repository_name_exists_exception :: [
  ]

  @type repository_name_id_pair :: [
    repository_id: repository_id,
    repository_name: repository_name,
  ]

  @type repository_name_id_pair_list :: [repository_name_id_pair]

  @type repository_name_list :: [repository_name]

  @type repository_name_required_exception :: [
  ]

  @type repository_names_required_exception :: [
  ]

  @type repository_not_found_list :: [repository_name]

  @type sort_by_enum :: binary

  @type update_default_branch_input :: [
    default_branch_name: branch_name,
    repository_name: repository_name,
  ]

  @type update_repository_description_input :: [
    repository_description: repository_description,
    repository_name: repository_name,
  ]

  @type update_repository_name_input :: [
    new_name: repository_name,
    old_name: repository_name,
  ]





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

  @spec batch_get_repositories(client :: ExAws.CodeCommit.t, input :: batch_get_repositories_input) :: ExAws.Request.JSON.response_t
  def batch_get_repositories(client, input) do
    request(client, "BatchGetRepositories", format_input(input))
  end

  @doc """
  Same as `batch_get_repositories/2` but raise on error.
  """
  @spec batch_get_repositories!(client :: ExAws.CodeCommit.t, input :: batch_get_repositories_input) :: ExAws.Request.JSON.success_t | no_return
  def batch_get_repositories!(client, input) do
    case batch_get_repositories(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateBranch

  Creates a new branch in a repository and points the branch to a commit.

  Note:Calling the create branch operation does not set a repository's
  default branch. To do this, call the update default branch operation.
  """

  @spec create_branch(client :: ExAws.CodeCommit.t, input :: create_branch_input) :: ExAws.Request.JSON.response_t
  def create_branch(client, input) do
    request(client, "CreateBranch", format_input(input))
  end

  @doc """
  Same as `create_branch/2` but raise on error.
  """
  @spec create_branch!(client :: ExAws.CodeCommit.t, input :: create_branch_input) :: ExAws.Request.JSON.success_t | no_return
  def create_branch!(client, input) do
    case create_branch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateRepository

  Creates a new, empty repository.
  """

  @spec create_repository(client :: ExAws.CodeCommit.t, input :: create_repository_input) :: ExAws.Request.JSON.response_t
  def create_repository(client, input) do
    request(client, "CreateRepository", format_input(input))
  end

  @doc """
  Same as `create_repository/2` but raise on error.
  """
  @spec create_repository!(client :: ExAws.CodeCommit.t, input :: create_repository_input) :: ExAws.Request.JSON.success_t | no_return
  def create_repository!(client, input) do
    case create_repository(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteRepository

  Deletes a repository. If a specified repository was already deleted, a null
  repository ID will be returned.

  **Deleting a repository also deletes all associated objects and metadata.
  After a repository is deleted, all future push calls to the deleted
  repository will fail.**
  """

  @spec delete_repository(client :: ExAws.CodeCommit.t, input :: delete_repository_input) :: ExAws.Request.JSON.response_t
  def delete_repository(client, input) do
    request(client, "DeleteRepository", format_input(input))
  end

  @doc """
  Same as `delete_repository/2` but raise on error.
  """
  @spec delete_repository!(client :: ExAws.CodeCommit.t, input :: delete_repository_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_repository!(client, input) do
    case delete_repository(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetBranch

  Retrieves information about a repository branch, including its name and the
  last commit ID.
  """

  @spec get_branch(client :: ExAws.CodeCommit.t, input :: get_branch_input) :: ExAws.Request.JSON.response_t
  def get_branch(client, input) do
    request(client, "GetBranch", format_input(input))
  end

  @doc """
  Same as `get_branch/2` but raise on error.
  """
  @spec get_branch!(client :: ExAws.CodeCommit.t, input :: get_branch_input) :: ExAws.Request.JSON.success_t | no_return
  def get_branch!(client, input) do
    case get_branch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
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

  @spec get_repository(client :: ExAws.CodeCommit.t, input :: get_repository_input) :: ExAws.Request.JSON.response_t
  def get_repository(client, input) do
    request(client, "GetRepository", format_input(input))
  end

  @doc """
  Same as `get_repository/2` but raise on error.
  """
  @spec get_repository!(client :: ExAws.CodeCommit.t, input :: get_repository_input) :: ExAws.Request.JSON.success_t | no_return
  def get_repository!(client, input) do
    case get_repository(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListBranches

  Gets information about one or more branches in a repository.
  """

  @spec list_branches(client :: ExAws.CodeCommit.t, input :: list_branches_input) :: ExAws.Request.JSON.response_t
  def list_branches(client, input) do
    request(client, "ListBranches", format_input(input))
  end

  @doc """
  Same as `list_branches/2` but raise on error.
  """
  @spec list_branches!(client :: ExAws.CodeCommit.t, input :: list_branches_input) :: ExAws.Request.JSON.success_t | no_return
  def list_branches!(client, input) do
    case list_branches(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListRepositories

  Gets information about one or more repositories.
  """

  @spec list_repositories(client :: ExAws.CodeCommit.t, input :: list_repositories_input) :: ExAws.Request.JSON.response_t
  def list_repositories(client, input) do
    request(client, "ListRepositories", format_input(input))
  end

  @doc """
  Same as `list_repositories/2` but raise on error.
  """
  @spec list_repositories!(client :: ExAws.CodeCommit.t, input :: list_repositories_input) :: ExAws.Request.JSON.success_t | no_return
  def list_repositories!(client, input) do
    case list_repositories(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateDefaultBranch

  Sets or changes the default branch name for the specified repository.

  Note:If you use this operation to change the default branch name to the
  current default branch name, a success message is returned even though the
  default branch did not change.
  """

  @spec update_default_branch(client :: ExAws.CodeCommit.t, input :: update_default_branch_input) :: ExAws.Request.JSON.response_t
  def update_default_branch(client, input) do
    request(client, "UpdateDefaultBranch", format_input(input))
  end

  @doc """
  Same as `update_default_branch/2` but raise on error.
  """
  @spec update_default_branch!(client :: ExAws.CodeCommit.t, input :: update_default_branch_input) :: ExAws.Request.JSON.success_t | no_return
  def update_default_branch!(client, input) do
    case update_default_branch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
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

  @spec update_repository_description(client :: ExAws.CodeCommit.t, input :: update_repository_description_input) :: ExAws.Request.JSON.response_t
  def update_repository_description(client, input) do
    request(client, "UpdateRepositoryDescription", format_input(input))
  end

  @doc """
  Same as `update_repository_description/2` but raise on error.
  """
  @spec update_repository_description!(client :: ExAws.CodeCommit.t, input :: update_repository_description_input) :: ExAws.Request.JSON.success_t | no_return
  def update_repository_description!(client, input) do
    case update_repository_description(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateRepositoryName

  Renames a repository.
  """

  @spec update_repository_name(client :: ExAws.CodeCommit.t, input :: update_repository_name_input) :: ExAws.Request.JSON.response_t
  def update_repository_name(client, input) do
    request(client, "UpdateRepositoryName", format_input(input))
  end

  @doc """
  Same as `update_repository_name/2` but raise on error.
  """
  @spec update_repository_name!(client :: ExAws.CodeCommit.t, input :: update_repository_name_input) :: ExAws.Request.JSON.success_t | no_return
  def update_repository_name!(client, input) do
    case update_repository_name(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
