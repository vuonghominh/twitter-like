defmodule Helper.Controller do
  import Plug.Conn

  def json_response(conn, status, message \\ "ok", body \\ %{}) do
    resp_body = case body do
      b when b in [nil, %{}] -> %{message: message}
      _ -> %{data: body, message: message}
    end
    conn
      |> put_resp_content_type("application/json")
      |> send_resp(status, Poison.encode!(resp_body))
  end

  def strong_params(params, accepted) do
    Enum.reduce(accepted, %{}, fn(key, acc) -> 
      value = Map.get(params, Atom.to_string(key)) 
      Map.put(acc, key, value)
    end)
  end
end