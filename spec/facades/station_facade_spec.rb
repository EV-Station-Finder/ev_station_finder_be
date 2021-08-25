require 'rails_helper'

RSpec.describe StationFacade do
  describe "::get_stations" do
    it "should return an array of station objects" do
      location = "Denver, CO"
      result = StationFacade.get_stations(location)

      expect(result).to be_a(Array)
      expect(result[0]).to be_a Station
    end
  end
end