defmodule Scrawley.PageController do
  use Scrawley.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
