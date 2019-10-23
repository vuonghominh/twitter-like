defmodule Api.User.Model do
  use Api, :model

  alias App.Repo
  alias __MODULE__

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Creates a user.
  ## Examples
      iex> create_user(%{field: value})
      {:ok, %Schema{}}
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}) do
    %Model{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  defp changeset(user, attrs) do
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