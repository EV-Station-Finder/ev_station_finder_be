require 'rails_helper'

RSpec.describe Station do
  describe "Station Object" do
    before:each do
      @incoming_hash = {:access_code=>"public",
                       :access_days_time=>"24 hours daily",
                       :access_detail_code=>nil,
                       :cards_accepted=>nil,
                       :date_last_confirmed=>"2021-08-25",
                       :expected_date=>nil,
                       :fuel_type_code=>"ELEC",
                       :groups_with_access_code=>"Public",
                       :id=>192187,
                       :open_date=>"2021-07-04",
                       :owner_type_code=>nil,
                       :status_code=>"E",
                       :station_name=>"Ideal Market Capitol Hill",
                       :station_phone=>"877-455-3833",
                       :updated_at=>"2021-08-25T01:13:53Z",
                       :facility_type=>nil,
                       :geocode_status=>"GPS",
                       :latitude=>39.7332915,
                       :longitude=>-104.9758502,
                       :city=>"Denver",
                       :intersection_directions=>nil,
                       :plus4=>nil,
                       :state=>"CO",
                       :street_address=>"900 E 11th Ave",
                       :zip=>"80218",
                       :country=>"US",
                       :bd_blends=>nil,
                       :cng_dispenser_num=>nil,
                       :cng_fill_type_code=>nil,
                       :cng_psi=>nil,
                       :cng_renewable_source=>nil,
                       :cng_total_compression=>nil,
                       :cng_total_storage=>nil,
                       :cng_vehicle_class=>nil,
                       :e85_blender_pump=>nil,
                       :e85_other_ethanol_blends=>nil,
                       :ev_connector_types=>["CHADEMO", "J1772COMBO"],
                       :ev_dc_fast_num=>2,
                       :ev_level1_evse_num=>nil,
                       :ev_level2_evse_num=>nil,
                       :ev_network=>"eVgo Network",
                       :ev_network_web=>"https://www.evgo.com/",
                       :ev_other_evse=>nil,
                       :ev_pricing=>nil,
                       :ev_renewable_source=>nil,
                       :hy_is_retail=>nil,
                       :hy_pressures=>nil,
                       :hy_standards=>nil,
                       :hy_status_link=>nil,
                       :lng_renewable_source=>nil,
                       :lng_vehicle_class=>nil,
                       :lpg_primary=>nil,
                       :lpg_nozzle_types=>nil,
                       :ng_fill_type_code=>nil,
                       :ng_psi=>nil,
                       :ng_vehicle_class=>nil,
                       :access_days_time_fr=>nil,
                       :intersection_directions_fr=>nil,
                       :bd_blends_fr=>nil,
                       :groups_with_access_code_fr=>"Public",
                       :ev_pricing_fr=>nil,
                       :ev_network_ids=>{:station=>["27102"], :posts=>["56139", "56141"]},
                       :distance=>0.59729,
                       :distance_km=>0.96125}
    end

    it "exists and had attributes" do
      new_station = Station.new(@incoming_hash)

      expect(new_station).to be_a Station
      expect(new_station.id).to be_nil
      expect(new_station.api_id).to eq(192187)
      expect(new_station.name).to eq("Ideal Market Capitol Hill")
      expect(new_station.distance).to eq(0.59729)
      expect(new_station.status).to eq("Available")
      expect(new_station.hours).to eq("24 hours daily")
      expect(new_station.ev_network).to eq("eVgo Network")
      expect(new_station.street_address).to eq("900 E 11th Ave")
      expect(new_station.city).to eq("Denver")
      expect(new_station.state).to eq("CO")
      expect(new_station.zip_code).to eq("80218")
    end

    it "Status is 'Coming Soon'" do
      @incoming_hash[:status_code] = "P"
      new_station = Station.new(@incoming_hash)
      expect(new_station.status).to eq("Coming Soon")
    end

    it "Status is 'Temporarily Closed'" do
      @incoming_hash[:status_code] = "T"
      new_station = Station.new(@incoming_hash)
      expect(new_station.status).to eq("Temporarily Closed")
    end

    it "Status is 'Temporarily Closed'" do
      @incoming_hash[:status_code] = ""
      new_station = Station.new(@incoming_hash)
      expect(new_station.status).to eq("Status Unavailable")
    end
  end
end