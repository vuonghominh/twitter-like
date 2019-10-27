defmodule App.Endpoint do
  require Logger

  use Plug.Router

  plug Plug.Logger
  plug CORSPlug, origin: "*"
  plug App.Router

  match _ do
    send_resp(conn, 404, "oops")
  end

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

  defp config, do: Application.fetch_env(:app, __MODULE__)
end