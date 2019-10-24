defmodule Api.Auth.Router do
  use Api, :router
  alias Api.Auth.Controller

  post "/login" do
    conn |> Controller.login()
  end
end