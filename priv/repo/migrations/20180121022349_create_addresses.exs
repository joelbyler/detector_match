defmodule DetectorMatch.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"
    create table(:addresses) do
      add :label, :string

      timestamps()
    end

    # Add a field `point` with type `geometry(Point,4326)`.
    # This can store a "standard GPS" (epsg4326) coordinate pair {longitude,latitude}.
    execute("SELECT AddGeometryColumn ('addresses','point',4326,'POINT',2)")
    execute("CREATE INDEX restaurants_point_index on addresses USING gist (point)")

  end

  def down do
    drop table(:addresses)
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
