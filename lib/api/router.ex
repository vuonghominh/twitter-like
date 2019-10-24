defmodule Api.Router do
  use Api, :router
  alias Api.Ping.Router, as: PingRouter
  alias Api.Auth.Router, as: AuthRouter

  forward "/ping", to: PingRouter
  forward "/auth", to: AuthRouter
end