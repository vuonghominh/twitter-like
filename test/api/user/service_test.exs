defmodule Api.User.ServiceTest do
  use App.DataCase

  alias Api.User.Model
  alias Api.User.Service

  @valid_attrs %{email: "some@email", password: "some password"}
  @invalid_attrs %{email: nil, password: nil}

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %Model{} = user} = Service.create_user(@valid_attrs)
    assert user.email == "some@email"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Service.create_user(@invalid_attrs)
  end
end