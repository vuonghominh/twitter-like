defmodule Api.User.Model do
  use Api, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :otp_secret, :string
    field :auth_tokens, {:array, :string}, default: []

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :otp_secret, :auth_tokens])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> secure_password()
    |> init_otp_secret()
  end

  defp secure_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp secure_password(changeset) do
    changeset
  end

  defp init_otp_secret(changeset) do
    case get_change(changeset, :otp_secret) do
      v when v in [nil,""] -> put_change(changeset, :otp_secret, generate_otp_secret())
      _ -> changeset
    end
  end

  defp generate_otp_secret do
    :crypto.strong_rand_bytes(10) |> Base.encode32()
  end
end