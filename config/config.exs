use Mix.Config

config :app, App.Endpoint, port: 4000

import_config "#{Mix.env()}.exs"