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
end