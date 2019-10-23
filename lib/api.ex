defmodule Api do
  def controller do
    quote do
      import Plug.Conn
    end
  end

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def router do
    quote do
      use Plug.Router

      plug :match
      plug :dispatch
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end