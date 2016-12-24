defmodule Scrawley.Scrawl do
  use Scrawley.Web, :model

  schema "scrawls" do
    field :text, :string
    field :metadata, :map
    field :location, Geo.Point
    field :expiration, Timex.Ecto.DateTime
    
    field :distance, :float, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :location, :expiration])       # todo: figure out how to cast metadata.
    |> validate_required([:text, :location])
  end

  def within(query, point, radius_in_m) do
    {lng, lat} = point.coordinates
    srid = cond do
      is_nil(point.srid) -> 0
      true -> point.srid
    end
    from(scrawl in query, where: fragment("ST_DWithin(?::geography, ST_SetSRID(ST_MakePoint(?, ?), ?), ?)", scrawl.location, ^lng, ^lat, ^srid, ^radius_in_m))
  end

  def order_by_nearest(query, point) do
    {lng, lat} = point.coordinates
    srid = cond do
      is_nil(point.srid) -> 0
      true -> point.srid
    end
    from(scrawl in query, order_by: fragment("? <-> ST_SetSRID(ST_MakePoint(?,?), ?)", scrawl.location, ^lng, ^lat, ^srid))
  end

  def select_with_distance(query, point) do
    {lng, lat} = point.coordinates
    srid = cond do
      is_nil(point.srid) -> 0
      true -> point.srid
    end
    from(scrawl in query,
         select: %{scrawl | distance: fragment("ST_Distance_Sphere(?, ST_SetSRID(ST_MakePoint(?,?), ?))", scrawl.location, ^lng, ^lat, ^srid)})
  end
  
  def to_json(struct) do
    %{
      id: struct.id,
      text: struct.text,
      location: Geo.JSON.encode(struct.location),
      inserted_at: struct.inserted_at,
      expires_in: cond do
        (is_nil(struct.expiration) || is_nil(struct.inserted_at)) -> nil
        true -> Timex.diff(struct.expiration, struct.inserted_at, :milliseconds)
      end
    }
  end

  # radius defaults to 500 meters
  def nearby_scrawls(point, last_scrawl \\ 0, radius \\ 500) do
    base_query = from scrawl in __MODULE__,
                 where: (scrawl.id > ^last_scrawl \
                         and (is_nil(scrawl.expiration) or scrawl.expiration >= ^Timex.now))
    Scrawley.Repo.all Scrawley.Scrawl.within(base_query, Geo.JSON.decode(point), radius)
  end

end
