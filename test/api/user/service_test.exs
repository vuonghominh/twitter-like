defmodule Api.User.ServiceTest do
  use App.DataCase

  alias Api.User.Model
  alias Api.User.Service

  @valid_attrs %{email: "some@email", password: "some password"}
  @invalid_attrs %{email: nil, password: nil}

  describe "create_user/1" do
    test "with valid data creates a user" do
      assert {:ok, %Model{} = user} = Service.create_user(@valid_attrs)
      assert user.email == "some@email"
      assert user.otp_secret != nil
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Service.create_user(@invalid_attrs)
    end
  end

  test "generate_auth_token/1 returns a token" do
    {:ok, %Model{} = user} = Service.create_user(@valid_attrs)
    token = Service.generate_auth_token(user)
    assert token != nil
  end
end