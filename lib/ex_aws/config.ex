defmodule ExAws.Config do
  require Record

  def for_service(service_name) do
    service_name |> get
  end

  def get(attr) do
    Application.get_env(:ex_aws, attr)
  end

end
