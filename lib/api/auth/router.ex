defmodule Api.Auth.Router do
  use Api, :router
  alias Api.Auth.Controller
  alias App.Plug.VerifyRequest
  
  plug :match
  plug VerifyRequest, except_paths: ["logout"]
  plug :dispatch

  post "/login" do
    conn |> Controller.login()
  end

  post "/logout" do
    conn |> Controller.logout()
  end
end