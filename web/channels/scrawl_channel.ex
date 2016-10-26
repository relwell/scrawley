defmodule Scrawley.ScrawlChannel do
  use Phoenix.Channel
  
  def join("scrawls", _message, socket) do
    {:ok, socket}
  end
  
  def join("scrawls:" <> _some_tag, _message, socket) do
    # todo: support subscribing to different tags
    {:ok, socket}
  end

  def handle_in("scrawls", point, socket) do
    scrawls = Scrawley.Repo.all Scrawley.Scrawl.within("", Geo.JSON.decode(point), 500)  # within 500 meters
    [ok: scrawl_json] = Enum.map(scrawls, fn(x) -> Scrawley.Scrawl.to_json(x) end)
    {:reply, {:ok, %{scrawls: scrawl_json}}, socket}
  end
  
  def handle_in("scrawl", scrawl_params, _socket) do
    Scrawley.Repo.insert Scrawley.Scrawl.changeset(%Scrawley.Scrawl{}, scrawl_params)
  end
  
end