defmodule Api.Auth.Controller do
  use Api, :controller
  import Api.Auth.Service, only: [authenticate: 2, valid_totp_code?: 2, generate_totp_code: 1]
  import Api.User.Service, only: [generate_auth_token: 1, update_user: 2]

  def login(conn) do
    params = strong_params(conn.body_params, [:email, :password, :code])
    {status, message, data} = case params do
      %{email: nil} -> {400, "error", %{email: "is required"}}
      %{password: nil} -> {400, "error", %{password: "is required"}}
      %{email: email, password: password, code: code} -> case authenticate(email, password) do
        {:error, message} -> {401, message, nil}
        {:ok, user} when is_nil(code) -> {200, "ok", %{code: generate_totp_code(user)}}
        {:ok, user} -> case valid_totp_code?(user, code) do
          false -> {401, "unauthorized", nil}
          true -> {200, "ok", %{token: generate_auth_token(user)}}
        end
      end
    end
    conn |> json_response(status, message, data)
  end

  def logout(conn) do
    current_user = conn.assigns[:user]
    case update_user(current_user, %{auth_tokens: []}) do
      _ -> conn |> json_response(200, "ok")
    end
  end
end