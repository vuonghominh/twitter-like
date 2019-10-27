defmodule Api.Ping.Router do
  use Api, :router
  alias Api.Ping.Controller

  plug :match
  plug :dispatch

  get "/" do
    conn |> Controller.index()
  end
end