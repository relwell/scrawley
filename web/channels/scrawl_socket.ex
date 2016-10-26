defmodule Scrawley.ScrawlSocket do
  use Phoenix.Socket
  
  transport :websocket, Phoenix.Transports.WebSocket
  
  # We let anybody connect because Scrawley is anon af
  def connect(_params, socket) do
    {:ok, socket}
  end
  
  channel "scrawls", Scrawley.ScrawlChannel
  
  def id(_socket), do: nil
end