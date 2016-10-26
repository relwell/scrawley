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
    scrawls = Scrawley.Scrawl.nearby_scrawls(point)
    scrawl_json = case Enum.empty?(scrawls) do
      true -> []
      false -> Enum.map(scrawls, fn(x) -> Scrawley.Scrawl.to_json(x) end)
    end

    {:reply, {:ok, %{scrawls: scrawl_json}}, socket}
  end
  
  def handle_in("scrawl", scrawl_params, _socket) do
    Scrawley.Repo.insert Scrawley.Scrawl.changeset(%Scrawley.Scrawl{}, scrawl_params)
  end
  
end