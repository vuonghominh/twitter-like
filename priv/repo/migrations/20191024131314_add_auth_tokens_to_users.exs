defmodule App.Repo.Migrations.AddAuthTokensToUsers do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :auth_tokens, {:array, :text}, default: []
    end
  end

  def down do
    alter table(:users) do
      remove :auth_tokens
    end
  end
end
