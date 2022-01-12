require 'rails_helper'

RSpec.describe StationDetails do
  let(:station_hash) { {:access_code=>"public",
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
                   :distance_km=>0.96125} }

  let(:weather_hash) { {:lat=>44.7953,
                   :lon=>-91.4481,
                   :timezone=>"America/Chicago",
                   :timezone_offset=>-18000,
                   :current=>
                    {:dt=>1630448350,
                     :sunrise=>1630409244,
                     :sunset=>1630457104,
                     :temp=>76.93,
                     :feels_like=>76.86,
                     :pressure=>1012,
                     :humidity=>54,
                     :dew_point=>59.04,
                     :uvi=>1.63,
                     :clouds=>40,
                     :visibility=>10000,
                     :wind_speed=>1.01,
                     :wind_deg=>344,
                     :wind_gust=>8.01,
                     :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}]},
                   :hourly=>
                    [{:dt=>1630447200,
                      :temp=>76.93,
                      :feels_like=>76.86,
                      :pressure=>1012,
                      :humidity=>54,
                      :dew_point=>59.04,
                      :uvi=>1.63,
                      :clouds=>40,
                      :visibility=>10000,
                      :wind_speed=>7.54,
                      :wind_deg=>104,
                      :wind_gust=>10.11,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
                      :pop=>0.1},
                     {:dt=>1630450800,
                      :temp=>75.76,
                      :feels_like=>75.7,
                      :pressure=>1012,
                      :humidity=>57,
                      :dew_point=>59.45,
                      :uvi=>0.62,
                      :clouds=>42,
                      :visibility=>10000,
                      :wind_speed=>6.11,
                      :wind_deg=>109,
                      :wind_gust=>11.59,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
                      :pop=>0.1},
                     {:dt=>1630454400,
                      :temp=>73.94,
                      :feels_like=>73.9,
                      :pressure=>1012,
                      :humidity=>61,
                      :dew_point=>59.65,
                      :uvi=>0.13,
                      :clouds=>46,
                      :visibility=>10000,
                      :wind_speed=>6.31,
                      :wind_deg=>110,
                      :wind_gust=>12.19,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
                      :pop=>0.1},
                     {:dt=>1630458000,
                      :temp=>70.79,
                      :feels_like=>70.66,
                      :pressure=>1012,
                      :humidity=>66,
                      :dew_point=>58.87,
                      :uvi=>0,
                      :clouds=>61,
                      :visibility=>10000,
                      :wind_speed=>5.73,
                      :wind_deg=>117,
                      :wind_gust=>10.33,
                      :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}],
                      :pop=>0},
                     {:dt=>1630461600,
                      :temp=>66.88,
                      :feels_like=>66.76,
                      :pressure=>1013,
                      :humidity=>74,
                      :dew_point=>58.33,
                      :uvi=>0,
                      :clouds=>56,
                      :visibility=>10000,
                      :wind_speed=>5.99,
                      :wind_deg=>114,
                      :wind_gust=>9.01,
                      :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}],
                      :pop=>0},
                     {:dt=>1630465200,
                      :temp=>61.72,
                      :feels_like=>61.63,
                      :pressure=>1013,
                      :humidity=>86,
                      :dew_point=>57.25,
                      :uvi=>0,
                      :clouds=>40,
                      :visibility=>10000,
                      :wind_speed=>6.02,
                      :wind_deg=>111,
                      :wind_gust=>9.37,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}],
                      :pop=>0},
                     {:dt=>1630468800,
                      :temp=>60.01,
                      :feels_like=>59.94,
                      :pressure=>1014,
                      :humidity=>90,
                      :dew_point=>56.89,
                      :uvi=>0,
                      :clouds=>30,
                      :visibility=>10000,
                      :wind_speed=>4.79,
                      :wind_deg=>112,
                      :wind_gust=>6.15,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}],
                      :pop=>0},
                     {:dt=>1630472400,
                      :temp=>58.8,
                      :feels_like=>58.71,
                      :pressure=>1014,
                      :humidity=>92,
                      :dew_point=>56.44,
                      :uvi=>0,
                      :clouds=>24,
                      :visibility=>10000,
                      :wind_speed=>3.67,
                      :wind_deg=>105,
                      :wind_gust=>4.07,
                      :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02n"}],
                      :pop=>0},
                     {:dt=>1630476000,
                      :temp=>57.9,
                      :feels_like=>57.81,
                      :pressure=>1015,
                      :humidity=>94,
                      :dew_point=>55.96,
                      :uvi=>0,
                      :clouds=>20,
                      :visibility=>10000,
                      :wind_speed=>4.92,
                      :wind_deg=>102,
                      :wind_gust=>5.46,
                      :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02n"}],
                      :pop=>0},
                     {:dt=>1630479600,
                      :temp=>57.25,
                      :feels_like=>57.2,
                      :pressure=>1015,
                      :humidity=>96,
                      :dew_point=>55.85,
                      :uvi=>0,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>5.64,
                      :wind_deg=>112,
                      :wind_gust=>7.83,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
                      :pop=>0},
                     {:dt=>1630483200,
                      :temp=>56.89,
                      :feels_like=>56.8,
                      :pressure=>1015,
                      :humidity=>96,
                      :dew_point=>55.62,
                      :uvi=>0,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>5.64,
                      :wind_deg=>137,
                      :wind_gust=>8.81,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
                      :pop=>0},
                     {:dt=>1630486800,
                      :temp=>56.44,
                      :feels_like=>56.3,
                      :pressure=>1015,
                      :humidity=>96,
                      :dew_point=>55.33,
                      :uvi=>0,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.79,
                      :wind_deg=>146,
                      :wind_gust=>6.49,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
                      :pop=>0},
                     {:dt=>1630490400,
                      :temp=>56.14,
                      :feels_like=>55.96,
                      :pressure=>1016,
                      :humidity=>96,
                      :dew_point=>54.82,
                      :uvi=>0,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.25,
                      :wind_deg=>142,
                      :wind_gust=>4.68,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
                      :pop=>0},
                     {:dt=>1630494000,
                      :temp=>55.85,
                      :feels_like=>55.65,
                      :pressure=>1016,
                      :humidity=>96,
                      :dew_point=>54.52,
                      :uvi=>0,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.29,
                      :wind_deg=>121,
                      :wind_gust=>4.41,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
                      :pop=>0},
                     {:dt=>1630497600,
                      :temp=>55.71,
                      :feels_like=>55.54,
                      :pressure=>1017,
                      :humidity=>97,
                      :dew_point=>54.59,
                      :uvi=>0,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.72,
                      :wind_deg=>113,
                      :wind_gust=>5.61,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630501200,
                      :temp=>59.34,
                      :feels_like=>59.2,
                      :pressure=>1017,
                      :humidity=>90,
                      :dew_point=>56.14,
                      :uvi=>0.48,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.5,
                      :wind_deg=>116,
                      :wind_gust=>6.85,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630504800,
                      :temp=>63.45,
                      :feels_like=>63.16,
                      :pressure=>1018,
                      :humidity=>78,
                      :dew_point=>56.43,
                      :uvi=>1.42,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.41,
                      :wind_deg=>121,
                      :wind_gust=>5.55,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630508400,
                      :temp=>67.35,
                      :feels_like=>66.88,
                      :pressure=>1018,
                      :humidity=>66,
                      :dew_point=>55.67,
                      :uvi=>2.88,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>4.76,
                      :wind_deg=>113,
                      :wind_gust=>4.92,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630512000,
                      :temp=>70.63,
                      :feels_like=>70.16,
                      :pressure=>1017,
                      :humidity=>59,
                      :dew_point=>55.38,
                      :uvi=>4.49,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>5.26,
                      :wind_deg=>104,
                      :wind_gust=>5.26,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630515600,
                      :temp=>73.06,
                      :feels_like=>72.61,
                      :pressure=>1017,
                      :humidity=>54,
                      :dew_point=>55.51,
                      :uvi=>5.81,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>5.14,
                      :wind_deg=>98,
                      :wind_gust=>5.14,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630519200,
                      :temp=>74.88,
                      :feels_like=>74.46,
                      :pressure=>1017,
                      :humidity=>51,
                      :dew_point=>55.49,
                      :uvi=>6.38,
                      :clouds=>0,
                      :visibility=>10000,
                      :wind_speed=>5.39,
                      :wind_deg=>95,
                      :wind_gust=>5.48,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630522800,
                      :temp=>76.32,
                      :feels_like=>75.96,
                      :pressure=>1017,
                      :humidity=>49,
                      :dew_point=>55.44,
                      :uvi=>6,
                      :clouds=>1,
                      :visibility=>10000,
                      :wind_speed=>6.46,
                      :wind_deg=>90,
                      :wind_gust=>6.69,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630526400,
                      :temp=>76.89,
                      :feels_like=>76.44,
                      :pressure=>1016,
                      :humidity=>46,
                      :dew_point=>54.7,
                      :uvi=>4.79,
                      :clouds=>1,
                      :visibility=>10000,
                      :wind_speed=>6.42,
                      :wind_deg=>101,
                      :wind_gust=>5.73,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630530000,
                      :temp=>76.96,
                      :feels_like=>76.51,
                      :pressure=>1016,
                      :humidity=>46,
                      :dew_point=>54.32,
                      :uvi=>3.19,
                      :clouds=>2,
                      :visibility=>10000,
                      :wind_speed=>6.69,
                      :wind_deg=>111,
                      :wind_gust=>4.94,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630533600,
                      :temp=>76.19,
                      :feels_like=>75.72,
                      :pressure=>1016,
                      :humidity=>47,
                      :dew_point=>54.43,
                      :uvi=>1.66,
                      :clouds=>7,
                      :visibility=>10000,
                      :wind_speed=>7.27,
                      :wind_deg=>115,
                      :wind_gust=>5.23,
                      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
                      :pop=>0},
                     {:dt=>1630537200,
                      :temp=>74.1,
                      :feels_like=>73.74,
                      :pressure=>1016,
                      :humidity=>54,
                      :dew_point=>56.62,
                      :uvi=>0.63,
                      :clouds=>12,
                      :visibility=>10000,
                      :wind_speed=>7.85,
                      :wind_deg=>124,
                      :wind_gust=>7.9,
                      :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}],
                      :pop=>0},
                     {:dt=>1630540800,
                      :temp=>69.35,
                      :feels_like=>69.08,
                      :pressure=>1016,
                      :humidity=>66,
                      :dew_point=>57.2,
                      :uvi=>0.12,
                      :clouds=>26,
                      :visibility=>10000,
                      :wind_speed=>8.01,
                      :wind_deg=>129,
                      :wind_gust=>15.28,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
                      :pop=>0},
                     {:dt=>1630544400,
                      :temp=>63.61,
                      :feels_like=>63.28,
                      :pressure=>1017,
                      :humidity=>77,
                      :dew_point=>56.17,
                      :uvi=>0,
                      :clouds=>61,
                      :visibility=>10000,
                      :wind_speed=>7.61,
                      :wind_deg=>133,
                      :wind_gust=>15.75,
                      :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}],
                      :pop=>0},
                     {:dt=>1630548000,
                      :temp=>61.29,
                      :feels_like=>60.78,
                      :pressure=>1017,
                      :humidity=>78,
                      :dew_point=>54.23,
                      :uvi=>0,
                      :clouds=>71,
                      :visibility=>10000,
                      :wind_speed=>7.25,
                      :wind_deg=>138,
                      :wind_gust=>14.72,
                      :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}],
                      :pop=>0},
                     {:dt=>1630551600,
                      :temp=>59.13,
                      :feels_like=>58.32,
                      :pressure=>1017,
                      :humidity=>76,
                      :dew_point=>51.55,
                      :uvi=>0,
                      :clouds=>51,
                      :visibility=>10000,
                      :wind_speed=>6.62,
                      :wind_deg=>142,
                      :wind_gust=>11.18,
                      :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}],
                      :pop=>0},
                     {:dt=>1630555200,
                      :temp=>57.43,
                      :feels_like=>56.44,
                      :pressure=>1018,
                      :humidity=>76,
                      :dew_point=>49.77,
                      :uvi=>0,
                      :clouds=>42,
                      :visibility=>10000,
                      :wind_speed=>6.02,
                      :wind_deg=>152,
                      :wind_gust=>9.1,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}],
                      :pop=>0},
                     {:dt=>1630558800,
                      :temp=>56.17,
                      :feels_like=>55.17,
                      :pressure=>1019,
                      :humidity=>78,
                      :dew_point=>49.24,
                      :uvi=>0,
                      :clouds=>36,
                      :visibility=>10000,
                      :wind_speed=>5.86,
                      :wind_deg=>158,
                      :wind_gust=>8.59,
                      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03n"}],
                      :pop=>0}
  ]} }
  
  let!(:user1) { User.create(first_name: 'Bill',
       last_name: 'Seldon',
       email: 'email@example.com',
       street_address: '2954 Virginia Beach Boulevard',
       city: 'Virginia Beach',
       state: 'Virginia',
       zip_code: '23452',
       password: 'verysecurepassword') }
        
  let(:station1) { Station.create!(api_id: "192187") }
  let(:station2) { Station.create!(api_id: "152070") }
  let(:user_station1) { UserStation.create!(user_id: user1.id, station_id: station1.id) }

  describe "StationDetails Object" do
    describe "receives station data but no user_id" do
      it "exists, has attributes, and Status is available" do
        new_station = StationDetails.new(station_hash, weather_hash)

        expect(new_station).to be_a StationDetails
        expect(new_station.instance_variables.count).to eq(14)
        expect(new_station.id).to be_nil
        expect(new_station.api_id).to eq(192187)
        expect(new_station.name).to eq("Ideal Market Capitol Hill")
        expect(new_station.status).to eq("Available")
        expect(new_station.hours).to eq("24 hours daily")
        expect(new_station.ev_connector_types).to eq(["CHADEMO", "J1772COMBO"])
        expect(new_station.ev_network).to eq("eVgo Network")
        expect(new_station.street_address).to eq("900 E 11th Ave")
        expect(new_station.city).to eq("Denver")
        expect(new_station.state).to eq("CO")
        expect(new_station.zip_code).to eq("80218")
        expect(new_station.is_favorited).to eq("User token not provided")
        expect(new_station.accepted_payments).to eq(["No Payment Options Available"])
        expect(new_station.hourly_weather).to be_an Array
        expect(new_station.hourly_weather[0]).to be_an HourlyWeather
      end

      it "Status is 'Coming Soon'" do
        station_hash[:status_code] = "P"
        new_station = StationDetails.new(station_hash, weather_hash)
        expect(new_station.status).to eq("Coming Soon")
      end

      it "Status is 'Temporarily Closed'" do
        station_hash[:status_code] = "T"
        new_station = StationDetails.new(station_hash, weather_hash)
        expect(new_station.status).to eq("Temporarily Closed")
      end

      it "Status is 'Status Unavailable'" do
        station_hash[:status_code] = ""
        new_station = StationDetails.new(station_hash, weather_hash)
        expect(new_station.status).to eq("Status Unavailable")
      end

      it "Payment Method if station is a Tesla Station'" do
        station_hash[:ev_network] = "Tesla"
        new_station = StationDetails.new(station_hash, weather_hash)
        expect(new_station.accepted_payments).to eq(["Tesla Payment Network"])
      end

      it "Only less popular payment methods available and Payment Info is Unavailable'" do
        station_hash[:cards_accepted] = "Checks CREDIT ARI"
        new_station = StationDetails.new(station_hash, weather_hash)
        expect(new_station.accepted_payments).to eq(["Payment Information Unavailable"])
      end

      it "Account for when ev_network is nil/null" do
        station_hash[:ev_network] = nil
        new_station = StationDetails.new(station_hash, weather_hash)
        expect(new_station.ev_network).to eq("Non-Networked")
      end
    end
    
    describe "receives both station data and a user_id" do
      it "The station's api_id does not correspond with a station in the database" do
        station_hash[:id] = 1
        new_station = StationDetails.new(station_hash, weather_hash, user1.id)
        
        expect(new_station).to be_a StationDetails
        expect(new_station.instance_variables.count).to eq(14)
        expect(new_station.id).to be_nil
        expect(new_station.api_id).to eq(1)
        expect(new_station.name).to eq("Ideal Market Capitol Hill")
        expect(new_station.status).to eq("Available")
        expect(new_station.hours).to eq("24 hours daily")
        expect(new_station.ev_connector_types).to eq(["CHADEMO", "J1772COMBO"])
        expect(new_station.ev_network).to eq("eVgo Network")
        expect(new_station.street_address).to eq("900 E 11th Ave")
        expect(new_station.city).to eq("Denver")
        expect(new_station.state).to eq("CO")
        expect(new_station.zip_code).to eq("80218")
        expect(new_station.is_favorited).to eq(false)
        expect(new_station.accepted_payments).to eq(["No Payment Options Available"])
        expect(new_station.hourly_weather).to be_an Array
        expect(new_station.hourly_weather[0]).to be_an HourlyWeather
      end
      
      it "The station api_id and the user_id correspond with a user and station in the database, but there is no corresponding user_station" do
        new_station = StationDetails.new(station_hash, weather_hash, user1.id)
        
        expect(new_station).to be_a StationDetails
        expect(new_station.instance_variables.count).to eq(14)
        expect(new_station.id).to be_nil
        expect(new_station.api_id).to eq(192187)
        expect(new_station.name).to eq("Ideal Market Capitol Hill")
        expect(new_station.status).to eq("Available")
        expect(new_station.hours).to eq("24 hours daily")
        expect(new_station.ev_connector_types).to eq(["CHADEMO", "J1772COMBO"])
        expect(new_station.ev_network).to eq("eVgo Network")
        expect(new_station.street_address).to eq("900 E 11th Ave")
        expect(new_station.city).to eq("Denver")
        expect(new_station.state).to eq("CO")
        expect(new_station.zip_code).to eq("80218")
        expect(new_station.is_favorited).to eq(false)
        expect(new_station.accepted_payments).to eq(["No Payment Options Available"])
        expect(new_station.hourly_weather).to be_an Array
        expect(new_station.hourly_weather[0]).to be_an HourlyWeather
      end
      
      it "The station api_id and the user_id correspond with a user and station in the database, and there is a corresponding user_station" do
        user_station1 # Create user_station
        new_station = StationDetails.new(station_hash, weather_hash, user1.id)
        
        expect(new_station).to be_a StationDetails
        expect(new_station.instance_variables.count).to eq(14)
        expect(new_station.id).to be_nil
        expect(new_station.api_id).to eq(192187)
        expect(new_station.name).to eq("Ideal Market Capitol Hill")
        expect(new_station.status).to eq("Available")
        expect(new_station.hours).to eq("24 hours daily")
        expect(new_station.ev_connector_types).to eq(["CHADEMO", "J1772COMBO"])
        expect(new_station.ev_network).to eq("eVgo Network")
        expect(new_station.street_address).to eq("900 E 11th Ave")
        expect(new_station.city).to eq("Denver")
        expect(new_station.state).to eq("CO")
        expect(new_station.zip_code).to eq("80218")
        expect(new_station.is_favorited).to eq(true)
        expect(new_station.accepted_payments).to eq(["No Payment Options Available"])
        expect(new_station.hourly_weather).to be_an Array
        expect(new_station.hourly_weather[0]).to be_an HourlyWeather
      end
      
      it "The station api_id and the user_id correspond with a user and station in the database, and there is a corresponding user_station, but the user_station attribute 'is_favorited' is set to false" do
        user_station1.update!(is_favorited: false) # Create user_station and set favorited to false
        new_station = StationDetails.new(station_hash, weather_hash, user1.id)
        
        expect(new_station).to be_a StationDetails
        expect(new_station.instance_variables.count).to eq(14)
        expect(new_station.id).to be_nil
        expect(new_station.api_id).to eq(192187)
        expect(new_station.name).to eq("Ideal Market Capitol Hill")
        expect(new_station.status).to eq("Available")
        expect(new_station.hours).to eq("24 hours daily")
        expect(new_station.ev_connector_types).to eq(["CHADEMO", "J1772COMBO"])
        expect(new_station.ev_network).to eq("eVgo Network")
        expect(new_station.street_address).to eq("900 E 11th Ave")
        expect(new_station.city).to eq("Denver")
        expect(new_station.state).to eq("CO")
        expect(new_station.zip_code).to eq("80218")
        expect(new_station.is_favorited).to eq(false)
        expect(new_station.accepted_payments).to eq(["No Payment Options Available"])
        expect(new_station.hourly_weather).to be_an Array
        expect(new_station.hourly_weather[0]).to be_an HourlyWeather
      end
    end
  end
end
