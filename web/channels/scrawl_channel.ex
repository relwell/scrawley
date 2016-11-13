defmodule Scrawley.ScrawlChannel do
  use Phoenix.Channel
  
  def join("scrawls", _message, socket) do
    {:ok, socket}
  end
  
  def join("scrawl", _message, socket) do
    {:ok, socket}
  end
  
  def join("scrawls:" <> _some_tag, _message, socket) do
    # todo: support subscribing to different tags
    {:ok, socket}
  end

  def handle_in("scrawls", %{"last_scrawl" => last_scrawl, "point" => point}, socket) do
    scrawls = Scrawley.Scrawl.nearby_scrawls(point, last_scrawl)
    scrawl_json = case Enum.empty?(scrawls) do
      true -> []
      false -> Enum.map(scrawls, fn(x) -> Scrawley.Scrawl.to_json(x) end)
    end

    {:reply, {:ok, %{scrawls: scrawl_json}}, socket}
  end
  
  def handle_in("scrawls", scrawl_params, socket) do
    write_scrawl(scrawl_params, socket)
  end
  
  def handle_in("scrawl", scrawl_params, socket) do
    write_scrawl(scrawl_params, socket)
  end
  
  def write_scrawl(scrawl_params, socket) do
    IO.puts inspect(scrawl_params)
    scrawl_response = Scrawley.Repo.insert Scrawley.Scrawl.changeset(%Scrawley.Scrawl{}, scrawl_params)
    case scrawl_response do
      {:ok, scrawl_response} -> reply_and_broadcast(scrawl_response, socket)
      {:error, reason} -> {:error, reason}
    end
  end

  def reply_and_broadcast(%Scrawley.Scrawl{}=scrawl, socket) do
    # todo
    #send(self, {:after_scrawl, scrawl})
    {:reply, {:ok, %{scrawl_id: scrawl.id}}, socket}
  end
  
  def handle_info({:after_scrawl, scrawl}, socket) do
    broadcast! socket, "scrawls", scrawl
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end
  
end