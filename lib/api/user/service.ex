defmodule Api.User.Service do
  alias App.Repo
  alias Api.User.Model, as: User

  @doc """
  Creates a user.
  ## Examples
      iex> create_user(%{field: value})
      {:ok, %Schema{}}
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the current interval TOTP code for a given user.
  ## Examples
      iex> generate_totp_code(user)
      473820
  """
  def generate_totp_code(%User{otp_secret: secret}) do
    :pot.totp(secret)
  end

  def valid_totp_code?(%User{otp_secret: secret}, token) do
    :pot.valid_totp(token, secret)
  end
end