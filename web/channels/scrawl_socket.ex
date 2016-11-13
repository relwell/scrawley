defmodule Scrawley.ScrawlSocket do
  use Phoenix.Socket
  
  channel "scrawls", Scrawley.ScrawlChannel
  channel "scrawl", Scrawley.ScrawlChannel
  
  transport :websocket, Phoenix.Transports.WebSocket, timeout: 45_000
  
  # We let anybody connect because Scrawley is anon af
  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end