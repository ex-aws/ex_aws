defmodule ExAws.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExAws
  """

  @callback request(ExAws.Operation.t()) :: {:ok, term} | {:error, term}
  @callback request(ExAws.Operation.t(), Keyword.t()) :: {:ok, term} | {:error, term}

  @callback request!(ExAws.Operation.t()) :: term | no_return
  @callback request!(ExAws.Operation.t(), Keyword.t()) :: term | no_return

  @callback stream!(ExAws.Operation.t()) :: Enumerable.t()
  @callback stream!(ExAws.Operation.t(), Keyword.t()) :: Enumerable.t()
end
