defmodule Scrawley.ScrawlControllerTest do
  use Scrawley.ConnCase

  alias Scrawley.Scrawl
  @valid_attrs %{metadata: %{}, text: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, scrawl_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing scrawls"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, scrawl_path(conn, :new)
    assert html_response(conn, 200) =~ "New scrawl"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, scrawl_path(conn, :create), scrawl: @valid_attrs
    assert redirected_to(conn) == scrawl_path(conn, :index)
    assert Repo.get_by(Scrawl, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, scrawl_path(conn, :create), scrawl: @invalid_attrs
    assert html_response(conn, 200) =~ "New scrawl"
  end

  test "shows chosen resource", %{conn: conn} do
    scrawl = Repo.insert! %Scrawl{}
    conn = get conn, scrawl_path(conn, :show, scrawl)
    assert html_response(conn, 200) =~ "Show scrawl"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, scrawl_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    scrawl = Repo.insert! %Scrawl{}
    conn = get conn, scrawl_path(conn, :edit, scrawl)
    assert html_response(conn, 200) =~ "Edit scrawl"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    scrawl = Repo.insert! %Scrawl{}
    conn = put conn, scrawl_path(conn, :update, scrawl), scrawl: @valid_attrs
    assert redirected_to(conn) == scrawl_path(conn, :show, scrawl)
    assert Repo.get_by(Scrawl, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    scrawl = Repo.insert! %Scrawl{}
    conn = put conn, scrawl_path(conn, :update, scrawl), scrawl: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit scrawl"
  end

  test "deletes chosen resource", %{conn: conn} do
    scrawl = Repo.insert! %Scrawl{}
    conn = delete conn, scrawl_path(conn, :delete, scrawl)
    assert redirected_to(conn) == scrawl_path(conn, :index)
    refute Repo.get(Scrawl, scrawl.id)
  end
end
