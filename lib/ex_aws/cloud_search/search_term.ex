defmodule ExAws.CloudSearch.SearchTerm do
  defstruct q: "", cursor: "initial", size: 100, parser: "simple"

  def encode(search_term) do
    %{
      q: search_term.q,
      "q.parser": search_term.parser,
      size: search_term.size,
      cursor: search_term.cursor,
      format: "json"
    }
  end
end
