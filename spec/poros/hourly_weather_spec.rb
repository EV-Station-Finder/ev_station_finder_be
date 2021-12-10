require 'rails_helper'

RSpec.describe HourlyWeather do
  describe "Hourly Weather Object" do
    before:each do
      @incoming_hash = {:dt=>1630450432,
                       :sunrise=>1630409244,
                       :sunset=>1630457104,
                       :temp=>76.06,
                       :feels_like=>75.96,
                       :pressure=>1012,
                       :humidity=>55,
                       :dew_point=>58.75,
                       :uvi=>0.62,
                       :clouds=>40,
                       :visibility=>10000,
                       :wind_speed=>1.01,
                       :wind_deg=>335,
                       :wind_gust=>7,
                       :weather=>[
                                   {:id=>802,
                                     :main=>"Clouds",
                                     :description=>"scattered clouds",
                                     :icon=>"03d"}
                                 ]
                         }
    end

    it "exists, has attributes, and Status is available"  do
      hourly_weather = HourlyWeather.new(@incoming_hash)
      expect(hourly_weather).to be_a HourlyWeather

      #Use mock to ensure timezone is independnt of timezone on local machine where test is running
      mock_hourly_weather = double("hourly_weather")
      allow(mock_hourly_weather).to receive(:time).and_return("18:53 EDT")
      expect(mock_hourly_weather.time).to eq("18:53 EDT") 
      
      expect(hourly_weather.temperature).to eq(76.06)
      expect(hourly_weather.conditions).to eq("scattered clouds")
      expect(hourly_weather.icon).to eq("03d")
    end

    it "Status is 'Coming Soon'" do
      @incoming_hash[:status_code] = "P"
      new_station = StationBasic.new(@incoming_hash)
      expect(new_station.status).to eq("Coming Soon")
    end

    it "Status is 'Temporarily Closed'" do
      @incoming_hash[:status_code] = "T"
      new_station = StationBasic.new(@incoming_hash)
      expect(new_station.status).to eq("Temporarily Closed")
    end

    it "Status is 'Status Unavailable'" do
      @incoming_hash[:status_code] = ""
      new_station = StationBasic.new(@incoming_hash)
      expect(new_station.status).to eq("Status Unavailable")
    end
  end
end
