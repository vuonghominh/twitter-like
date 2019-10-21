defmodule Api.User.Model do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email,:password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> secure_password()
  end

  defp secure_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp secure_password(changeset) do
    changeset
  end
end