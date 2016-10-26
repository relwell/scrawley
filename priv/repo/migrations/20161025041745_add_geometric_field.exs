defmodule Scrawley.Repo.Migrations.AddGeometricField do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"
    execute "ALTER TABLE scrawls ADD COLUMN location geography(Point)"
  end
  
  def down do
    execute "ALTER TABLE scrawls DROP COLUMN location"
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
