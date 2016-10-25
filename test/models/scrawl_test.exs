defmodule Scrawley.ScrawlTest do
  use Scrawley.ModelCase

  alias Scrawley.Scrawl

  @valid_attrs %{metadata: %{}, text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Scrawl.changeset(%Scrawl{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Scrawl.changeset(%Scrawl{}, @invalid_attrs)
    refute changeset.valid?
  end
end
