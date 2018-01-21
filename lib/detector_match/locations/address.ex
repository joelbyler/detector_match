defmodule DetectorMatch.Locations.Address do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias DetectorMatch.Locations.Address


  schema "addresses" do
    field :label, :string
    field :point, Geo.Point
    field :distance, :float, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:label, :point])
    |> validate_required([:label, :point])
  end

  def within(query, point, radius_in_m) do
    {lng, lat} = point.coordinates
    from(address in query, where: fragment("ST_DWithin(?::geography, ST_SetSRID(ST_MakePoint(?, ?), ?), ?)", address.point, ^lng, ^lat, ^point.srid, ^radius_in_m))
  end

  def order_by_nearest(query, point) do
    {lng, lat} = point.coordinates
    from(address in query, order_by: fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", address.point, ^lng, ^lat, ^point.srid))
  end

  def select_with_distance(query, point) do
    {lng, lat} = point.coordinates
    from(address in query,
         select: %{address | distance: fragment("ST_Distance_Sphere(?, ST_SetSRID(ST_MakePoint(?,?), ?))", address.point, ^lng, ^lat, ^point.srid)})
  end
end
