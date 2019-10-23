defmodule Api.Ping.Controller do
  use Api, :controller

  def index(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{ message: "pong" }))
  end
end