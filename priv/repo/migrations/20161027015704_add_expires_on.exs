defmodule Scrawley.Repo.Migrations.AddExpiresOn do
  use Ecto.Migration

  def change do
    alter table(:scrawls) do
      add :expiration, :datetime
    end
  end
end
