use Mix.Config

config :app, ecto_repos: [App.Repo]
config :app, App.Endpoint, port: String.to_integer(System.get_env("PORT") || "4000")

import_config "#{Mix.env()}.exs"