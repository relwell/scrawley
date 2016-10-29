defmodule Scrawley.Factory do
  use ExMachina.Ecto, repo: Scrawley.Repo
  
  def scrawl_factory do
    %Scrawley.Scrawl{
      text: "This is my text",
      location: %Geo.Point{coordinates: {36.9639657, -121.8097725}, srid: 4326},
      expiration: Timex.shift(Timex.now, seconds: 60),
      inserted_at: Timex.now
    }
  end

end