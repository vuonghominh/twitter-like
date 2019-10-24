defmodule Api.Auth.Controller do
  use Api, :controller
  alias Api.Auth.Service
  alias Api.User.Service, as: UserService

  def login(conn) do
    params = strong_params(conn.body_params, [:email, :password, :code])
    case params do
      %{email: nil} -> conn |> json_response(400, "error", %{email: "is required"})
      %{password: nil} -> conn |> json_response(400, "error", %{password: "is required"})
      %{email: email, password: password, code: code} when is_nil(code) ->
        case Service.authenticate(email, password) do
          {:ok, user} -> conn |> json_response(200, "ok", %{code: UserService.generate_totp_code(user)})
          {:error, message} -> conn |> json_response(401, message)
        end
      _ -> conn |> json_response(401, "token")
    end
  end
end