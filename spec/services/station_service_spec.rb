require 'rails_helper'

RSpec.describe StationService do
  describe "::get_stations" do
    it "fetches stations based on location" do
      result = StationService.get_stations("Denver, CO")
      expect(result).to be_a Hash
      expect(result[:location_country]).to be_a String
      expect(result[:fuel_stations]).to be_a Array
      expect(result[:fuel_stations][0]).to be_a Hash
      expect(result[:fuel_stations][0][:station_name]).to be_a String
      expect(result[:fuel_stations][0][:distance]).to be_a Float
      expect(result[:fuel_stations][0][:status_code]).to be_a String
      expect(result[:fuel_stations][0][:access_days_time]).to be_a String
      expect(result[:fuel_stations][0][:ev_network]).to be_a String
      expect(result[:fuel_stations][0][:street_address]).to be_a String
      expect(result[:fuel_stations][0][:city]).to be_a String
      expect(result[:fuel_stations][0][:state]).to be_a String
      expect(result[:fuel_stations][0][:zip]).to be_a String
    end
  end
end
