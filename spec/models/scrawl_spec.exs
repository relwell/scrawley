defmodule Scrawley.ScrawlSpec do
  
  use ESpec.Phoenix, model: Scrawl, async: true
  alias Scrawley.Scrawl
  
  import Scrawley.Factory
  
  context "to_json" do
    
    subject do: Scrawl.to_json(scrawl())
    
    let :scrawl, do: build(:scrawl)

    it "should include expected fields" do
      sub = subject
      obj = scrawl()
      for field <- [:id, :text, :inserted_at], do: expect(Map.fetch(sub, field)) |> to(eq(Map.fetch(obj, field)))
      expect sub.location |> to(eq(Geo.JSON.encode(obj.location)))
      
      # i wish we had timecop
      expect sub.expires_in |> to(eq(Timex.diff(obj.expiration, obj.inserted_at, :milliseconds)))
    end
    
  end
  
end