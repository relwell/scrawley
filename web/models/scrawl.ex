defmodule Scrawley.Scrawl do
  use Scrawley.Web, :model

  schema "scrawls" do
    field :text, :string
    field :metadata, :map
    field :location, Geo.Point
    field :distance, :float, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :location])       # todo: figure out how to cast metadata.
    |> validate_required([:text, :location])
  end

  def within(query, point, radius_in_m) do
    {lng, lat} = point.coordinates
    from(scrawl in query, where: fragment("ST_DWithin(?::geography, ST_SetSRID(ST_MakePoint(?, ?), ?), ?)", scrawl.location, ^lng, ^lat, ^point.srid, ^radius_in_m))
  end

  def order_by_nearest(query, point) do
    {lng, lat} = point.coordinates
    from(scrawl in query, order_by: fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", scrawl.location, ^lng, ^lat, ^point.srid))
  end

  def select_with_distance(query, point) do
    {lng, lat} = point.coordinates
    from(scrawl in query,
         select: %{scrawl | distance: fragment("ST_Distance_Sphere(?, ST_SetSRID(ST_MakePoint(?,?), ?))", scrawl.location, ^lng, ^lat, ^point.srid)})
  end
  
  def to_json(struct) do
    {latitude, longitude} = struct.location.coordinates
    Poison.encode(
      %{text: struct.text,
        location: %{
          coordinates: [latitude, longitude], 
          srid: struct.location.srid
        }
      })
  end
  
  
end
