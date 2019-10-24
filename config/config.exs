use Mix.Config

config :app, ecto_repos: [App.Repo]
config :app, App.Endpoint, port: String.to_integer(System.get_env("PORT") || "4000")
config :app, App.Guardian,
  issuer: "app",
  ttl: {1, :day},
  secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "secret"

import_config "#{Mix.env()}.exs"