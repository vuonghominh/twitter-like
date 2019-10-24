defmodule Api.Auth.Controller do
  use Api, :controller
  alias Api.Auth.Service

  def login(conn) do
    auth_params = Service.auth_params(conn.body_params)
    case auth_params do
      {:ok, %{email: email, password: password}} ->
        case Service.authenticate(email, password) do
          {:ok, user} -> conn |> json_response(200, "ok", Service.serialize(user))
          {:error, message} -> conn |> json_response(401, message)
        end
      {:error, error} -> conn |> json_response(403, "error", error)
    end
  end
end