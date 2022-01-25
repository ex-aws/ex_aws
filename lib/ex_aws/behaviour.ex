defmodule ExAws.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExAws.

  `ExAws` implements this behaviour.
  """

  @doc "See `ExAws.request/2`."
  @callback request(ExAws.Operation.t()) :: {:ok, term} | {:error, term}

  @doc "See `ExAws.request/2`."
  @callback request(ExAws.Operation.t(), Keyword.t()) :: {:ok, term} | {:error, term}

  @doc "See `ExAws.request!/2`."
  @callback request!(ExAws.Operation.t()) :: term | no_return

  @doc "See `ExAws.request!/2`."
  @callback request!(ExAws.Operation.t(), Keyword.t()) :: term | no_return

  @doc "See `ExAws.stream!/2`."
  @callback stream!(ExAws.Operation.t()) :: Enumerable.t()

  @doc "See `ExAws.stream!/2`."
  @callback stream!(ExAws.Operation.t(), Keyword.t()) :: Enumerable.t()
end
