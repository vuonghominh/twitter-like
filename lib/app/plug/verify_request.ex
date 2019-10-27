defmodule App.Plug.VerifyRequest do
  import Helper.Controller
  import Plug.Conn, only: [halt: 1, get_req_header: 2, assign: 3]

  def init(options), do: options

  def call(%Plug.Conn{path_info: [head | _] = _path} = conn, opts) do
    case head in opts[:except_paths] do
      true -> conn |> verify_request!()
      false -> conn
    end
  end

  defp verify_request!(conn) do
    conn
    |> get_auth_header
    |> authenticate
  end

  defp authenticate({conn, token}) do
    {status, user} = case App.Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        case App.Guardian.resource_from_claims(claims) do
          {:ok, user} -> {:ok, user}
          _ -> {:error, nil}
        end
      _ -> {:error, nil}
    end
    case status do
      :ok -> assign(conn, :user, user)
      _ -> conn |> send_401()
    end
  end

  defp authenticate({conn}) do
    conn |> send_401()
  end

  defp get_auth_header(conn) do
    case get_req_header(conn, "authorization") do
      [token] -> {conn, token}
      _ -> {conn}
    end
  end

  defp send_401(conn) do
    conn
    |> json_response(401, "unauthorized")
    |> halt
  end
end