defmodule App.Repo.Migrations.AddOtpSecretToUsers do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :otp_secret, :string
    end
  end

  def down do
    alter table(:users) do
      remove :otp_secret
    end
  end
end
