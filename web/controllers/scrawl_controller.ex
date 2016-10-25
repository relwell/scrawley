defmodule Scrawley.ScrawlController do
  use Scrawley.Web, :controller

  alias Scrawley.Scrawl

  def index(conn, _params) do
    scrawls = Repo.all(Scrawl)
    render(conn, "index.html", scrawls: scrawls)
  end

  def new(conn, _params) do
    changeset = Scrawl.changeset(%Scrawl{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scrawl" => scrawl_params}) do
    changeset = Scrawl.changeset(%Scrawl{}, scrawl_params)

    case Repo.insert(changeset) do
      {:ok, _scrawl} ->
        conn
        |> put_flash(:info, "Scrawl created successfully.")
        |> redirect(to: scrawl_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scrawl = Repo.get!(Scrawl, id)
    render(conn, "show.html", scrawl: scrawl)
  end

  def edit(conn, %{"id" => id}) do
    scrawl = Repo.get!(Scrawl, id)
    changeset = Scrawl.changeset(scrawl)
    render(conn, "edit.html", scrawl: scrawl, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scrawl" => scrawl_params}) do
    scrawl = Repo.get!(Scrawl, id)
    changeset = Scrawl.changeset(scrawl, scrawl_params)

    case Repo.update(changeset) do
      {:ok, scrawl} ->
        conn
        |> put_flash(:info, "Scrawl updated successfully.")
        |> redirect(to: scrawl_path(conn, :show, scrawl))
      {:error, changeset} ->
        render(conn, "edit.html", scrawl: scrawl, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scrawl = Repo.get!(Scrawl, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(scrawl)

    conn
    |> put_flash(:info, "Scrawl deleted successfully.")
    |> redirect(to: scrawl_path(conn, :index))
  end
end
