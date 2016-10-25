defmodule Scrawley.Scrawl do
  use Scrawley.Web, :model

  schema "scrawls" do
    field :text, :string
    field :metadata, :map
    field :location, Geo.Point

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
end
