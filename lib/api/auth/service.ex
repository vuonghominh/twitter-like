defmodule Api.Auth.Service do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  import Helper.Error, only: [errors_on: 1]
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

  def auth_params(attrs \\ %{}) do
    changeset = %User{}
      |> cast(attrs, [:email, :password])
      |> validate_required([:email, :password])
    case changeset do
      %{valid?: true, changes: params} -> {:ok, params}
      _ -> {:error, errors_on(changeset)}
    end
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

  # defp errors_on(%Ecto.Changeset{} = changeset) do
  #   traverse_errors(changeset, fn {msg, opts} ->
  #     Enum.reduce(opts, msg, fn {key, value}, acc ->
  #       String.replace(acc, "%{#{key}}", to_string(value))
  #     end)
  #   end)
  # end
end