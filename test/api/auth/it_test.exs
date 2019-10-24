defmodule Api.Auth.ItTest do
  use App.ConnCase
  alias Api.User.Service

  @current_user_attrs %{
    email: "current@email",
    password: "password"
  }

  def fixture(:user) do
    {:ok, user} = Service.create_user(@current_user_attrs)
    user
  end

  describe "Login" do
    setup [:create_user]

    test "responses error" do
      conn = post("/api/auth/login")
      assert conn.state == :sent
      assert conn.status == 400
      assert response_json(conn.resp_body) == %{
        "message" => "error",
        "data" => %{
          "email" => "is required"
        }
      }
    end

    test "responses unauthorized error" do
      conn = post("/api/auth/login", %{email: "any@email", password: "1234"})
      assert conn.state == :sent
      assert conn.status == 401
      assert response_json(conn.resp_body) == %{"message" => "email_and_password_do_not_match"}
    end

    test "responses OTP code when user credentials are good" do
      conn = post("/api/auth/login", %{
        email: @current_user_attrs.email,
        password: @current_user_attrs.password
      })
      %{"data" => %{ "code" => code }} = response_json(conn.resp_body)
      assert conn.state == :sent
      assert conn.status == 200
      assert is_binary(code)
    end

    test "response user when user credentials and OTP code are good", %{user: user} do
      credentials = %{
        email: @current_user_attrs.email,
        password: @current_user_attrs.password
      }
      conn = post("/api/auth/login", credentials)
      %{"data" => %{ "code" => code }} = response_json(conn.resp_body)
      conn = post("/api/auth/login", Map.put(credentials, :code, code))
      assert conn.status == 401
      assert response_json(conn.resp_body) == %{"message" => "token"}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end