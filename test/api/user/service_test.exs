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

  describe "generate_totp_code/1 & valid_totp_code?/2" do
    test "return a TOTP code" do
      {:ok, %Model{} = user} = Service.create_user(@valid_attrs)
      code = Service.generate_totp_code(user)
      assert code != nil
      assert Service.valid_totp_code?(user, code) == true
    end
  end
end