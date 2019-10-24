defmodule Api.Ping.Controller do
  use Api, :controller

  def index(conn) do
    conn |> json_response(200, "pong")
  end
end