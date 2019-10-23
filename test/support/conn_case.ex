defmodule App.ConnCase do
  use ExUnit.CaseTemplate
  use Plug.Test

  @opts App.Endpoint.init([])

  using do
    quote do
      import App.DataCase
      import App.ConnCase
    end
  end

  def response_json(body) do
    Poison.decode!(body)
  end

  def get(path) do
    conn(:get, path) |> App.Endpoint.call(@opts)
  end
end