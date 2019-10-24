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
  Updates a user.
  ## Examples
      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}
      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def get_user_by_id(id), do: Repo.get(User, id)

  def generate_auth_token(user) do
    token = generate_unique_auth_token(user)
    case update_user(user, %{auth_tokens: [token | user.auth_tokens]}) do
      {:error, _} -> nil
      _ -> token
    end
  end
  defp generate_unique_auth_token(user) do
    {:ok, token, _} = Map.take(user, [:id]) |> App.Guardian.encode_and_sign()
    if Enum.member?(user.auth_tokens, token) do
      generate_unique_auth_token(user)
    else
      token
    end
  end
end