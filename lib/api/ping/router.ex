defmodule Api.Ping.Router do
  use Api, :router
  alias Api.Ping.Controller

  get "/" do
    conn |> Controller.index()
  end
end