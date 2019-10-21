defmodule App.Repo do
  use Ecto.Repo,
    otp_app: :app,
    adapter: Ecto.Adapters.Postgres
  def init(_, config) do
    config = config
      |> Keyword.put(:username, System.get_env("POSTGRES_USER") || "postgres")
      |> Keyword.put(:password, System.get_env("POSTGRES_PASSWORD") || "postgres")
      |> Keyword.put(:database, System.get_env("POSTGRES_DATABASE") || "hello_dev")
      |> Keyword.put(:hostname, System.get_env("POSTGRES_HOST") || "localhost")
      |> Keyword.put(:port, (System.get_env("POSTGRES_PORT") || "5432") |> String.to_integer)
    {:ok, config}
  end
end
