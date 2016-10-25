defmodule Scrawley.Scrawl do
  use Scrawley.Web, :model

  schema "scrawls" do
    field :text, :string
    field :metadata, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :metadata])
    |> validate_required([:text, :metadata])
  end
end
