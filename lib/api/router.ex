defmodule Api.Router do
  use Api, :router
  alias Api.Ping.Router, as: PingRouter

  forward "/ping", to: PingRouter
end