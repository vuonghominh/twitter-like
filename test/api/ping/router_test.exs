defmodule Api.Ping.RouterTest do
  use App.ConnCase
  
  test "it returns pong" do
    conn = get("/api/ping")
    assert conn.state == :sent
    assert conn.status == 200
    assert response_json(conn.resp_body) == %{"message" => "pong"}
  end
end