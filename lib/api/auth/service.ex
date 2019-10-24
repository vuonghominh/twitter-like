defmodule Api.Auth.Service do
  import Ecto.Query, warn: false
  alias Api.User.Model, as: User
  alias App.Repo

  def authenticate(email, password) do
    query = from(u in User, where: u.email == ^email)
    query |> Repo.one() |> verify_password(password)
  end

  def serialize(%User{} = user) do
    %{
      id: user.id,
      email: user.email
    }
  end

  defp verify_password(nil, _) do
    Bcrypt.no_user_verify()
    {:error, "email_and_password_do_not_match"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "email_and_password_do_not_match"}
    end
  end
end