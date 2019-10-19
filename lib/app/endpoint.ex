defmodule App.Endpoint do
  use Plug.Router
  
  alias App.Router

  require Logger

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
    with {:ok, [port: port] = config} <- config() do
      Logger.info("Starting server at http://localhost:#{port}/")
      Plug.Cowboy.http(__MODULE__, [], config)
    end
  end

  forward "/ping", to: Router

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp config, do: Application.fetch_env(:app, __MODULE__)
end