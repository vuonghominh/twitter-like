defmodule Api.Ping.Router do
  use Api, :router
  alias Api.Ping.Controller

  get "/" do
    Controller.index(conn)
    # conn
    # |> put_resp_content_type("application/json")
    # |> send_resp(200, Poison.encode!(%{ message: "pong" }))
  end
end