use Mix.Config

config :app, App.Endpoint, port: String.to_integer(System.get_env("PORT") || "4000")