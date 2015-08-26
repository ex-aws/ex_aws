defmodule ExAws.CloudSearch.Client do
  use Behaviour

  @moduledoc """
  This module lets you interact with the AWS Cloud Search documents and search
  API enpoints (configuration endpoint at a further iteration).

  Usage:
  ```
  defmodule MyApp.CloudSearch do
    use ExAws.CloudSearch.Client, otp_app: :my_otp_app
  end
  ```

  In you config:
  ```
  config :my_otp_app, :ex_aws, :cloudsearch, # NOTE: cloudsearch instead of cloud_search
    cloud_search: [
      search_endpoint: "http(s)://search-your-domain-asdf1234.us-east-1.cloudsearch.amazonaws.com",
      document_endpoint: "http(s)://doc-your-domain-asdf1234.us-east-1.cloudsearch.amazonaws.com"
    ]
  ```

  If you only need one configuration (per application environment) it should suffice to use
  `ExAws.CloudSearch` and configure via `:ex_aws, :cloudsearch`.
  """

  @doc "Uploads multiple documents (add or delete) to the search domain"
  defcallback documents_batch(list :: List.t) :: ExAws.Request.response_t

  @doc "Executes a search as specified by the search term"
  defcallback search(search_term :: ExAws.CloudSearch.SearchTerm) :: ExAws.Request.response_t

  @doc "Executes a search as specified by the search term and returns an enumerable that does pagination"
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

    boilerplate = ExAws.Client.generate_boilerplate(__MODULE__, opts)

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
