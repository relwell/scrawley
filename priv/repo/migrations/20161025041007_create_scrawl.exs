defmodule Scrawley.Repo.Migrations.CreateScrawl do
  use Ecto.Migration

  def change do
    create table(:scrawls) do
      add :text, :string
      add :metadata, :map

      timestamps()
    end

  end
end
