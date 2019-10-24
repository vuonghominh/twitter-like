defmodule Api.Auth.ServiceTest do
  use App.DataCase

  alias Api.Auth.Service
  alias Api.User.Service, as: UserService

  @user_attrs %{email: "some@email", password: "some password"}

  test "generate_auth_token/1 & valid_totp_code/2" do
    {:ok, user} = UserService.create_user(@user_attrs)
    code = Service.generate_totp_code(user)
    assert code != nil
    assert Service.valid_totp_code?(user, code) == true
  end
end