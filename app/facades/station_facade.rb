class StationFacade
  def self.get_station(station_id, user_id=nil)
    station_response = StationService.get_station(station_id)
    if station_response[:alt_fuel_station].present?
      station_data = station_response[:alt_fuel_station]
      weather_data = WeatherService.get_hourly_weather(station_data[:latitude], station_data[:longitude])
      StationDetails.new(station_data, weather_data, user_id)
    else
      station_response
    end
  end
  
  def self.get_stations(location, user_id=nil)
    stations_data = StationService.get_stations(location)
    if (stations = stations_data[:fuel_stations]).nil?
      stations_data
    else
      stations.map do |station|
        StationBasic.new(station, user_id)
      end
    end
  end

  def self.get_favorite_stations(favorite_stations)
    stations = favorite_stations.map do |station|
      station_data = StationService.get_station(station.api_id)
      StationBasic.new(station_data[:alt_fuel_station])
    end
  end
end
