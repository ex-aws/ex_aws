defmodule ExAws.CloudSearch.Client do
  use Behaviour

  @moduledoc """
  """

  @doc "Uploads multiple documents (add or delete) to the search domain"
  defcallback documents_batch(list :: List.t) :: ExAws.Request.response_t

  @dec "Executes a search as specified by the search term"
  defcallback search(search_term :: ExAws.CloudSearch.SearchTerm) :: ExAws.Request.response_t

  defcallback stream_search(search_term :: ExAws.CloudSearch.SearchTerm) :: Enumerable.t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the ExAws.CloudSearch.Request.request/4.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(client :: %{}, http_method :: atom, path :: binary, data :: Keyword.t) :: ExAws.Request.response_t

  @doc "Retrieves the root AWS config for this client"
  defcallback config_root() :: Keyword.t

  defmacro __using__(opts) do

    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :cloudsearch
      unquote(boilerplate)

      @doc false
      def request(client, http_method, path, data) do
        ExAws.CloudSearch.Request.request(client, http_method, path, data)
      end

      defoverridable config_root: 0, request: 4
    end
  end
end
