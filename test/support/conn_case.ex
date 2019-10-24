defmodule App.ConnCase do
  use ExUnit.CaseTemplate
  use Plug.Test

  @opts App.Endpoint.init([])

  using do
    quote do
      import App.ConnCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(App.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(App.Repo, {:shared, self()})
    end

    :ok
  end

  def response_json(body) do
    Poison.decode!(body)
  end

  def get(path) do
    conn(:get, path) |> App.Endpoint.call(@opts)
  end

  def post(path, body \\ %{}) do
    conn(:post, path, body) |> App.Endpoint.call(@opts)
  end
end