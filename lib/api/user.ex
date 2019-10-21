defmodule Api.User do
  alias App.Repo
  alias Api.User.Model

  @doc """
  Creates a user.
  ## Examples
      iex> create_user(%{field: value})
      {:ok, %Model{}}
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}) do
    %Model{}
    |> Model.changeset(attrs)
    |> Repo.insert()
  end
end