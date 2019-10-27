defmodule App.Router do
  use Plug.Router
  use Plug.ErrorHandler
  if Mix.env == :dev do
    use Plug.Debugger
  end

  alias Api.Router, as: ApiRouter

  plug Plug.Static,
    at: "/",
    from: :app,
    gzip: false,
    only: ~w(static manifest.json css fonts images js favicon.ico robots.txt)
  plug :match
  plug :dispatch

  forward "/api", to: ApiRouter

  get "/*path" do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> send_file(200, "#{File.cwd!()}/priv/static/index.html")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end