defmodule App.Endpoint do
  use Plug.Router
  
  alias App.Router

  plug :match
  plug Plug.Parsers, parsers: [:json],
                     pass: ["application/json"],
                     json_decoder: Poison
  plug :dispatch

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    Plug.Cowboy.http(__MODULE__, [])
  end

  forward "/ping", to: Router

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end