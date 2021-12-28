class StationFacade
  def self.get_stations(location, user_id=nil)
    stations_data = StationService.get_stations(location)
    stations = stations_data[:fuel_stations]
    stations.map do |station|
      StationBasic.new(station, user_id)
    end
  end

  def self.get_favorite_stations(favorite_stations)
    stations = favorite_stations.map do |station|
      station_data = StationService.get_station(station.api_id)
      StationBasic.new(station_data[:alt_fuel_station])
    end
  end

  def self.get_station(id)
    station_response = StationService.get_station(id)
    if station_response[:alt_fuel_station].present?
      station_data = station_response[:alt_fuel_station]
      weather_data = WeatherService.get_hourly_weather(station_data[:latitude], station_data[:longitude])
      StationDetails.new(station_data, weather_data)
    else
      station_response
    end
  end
end
