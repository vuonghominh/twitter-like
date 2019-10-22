defmodule Api.UserTest do
  use App.DataCase

  alias Api.User

  describe "users" do
    alias Api.User.Model

    @valid_attrs %{email: "some email", password: "some password"}
    @invalid_attrs %{email: nil, password: nil}

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %Model{} = user} = User.create_user(@valid_attrs)
      assert user.email == "some email"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_user(@invalid_attrs)
    end
  end
end