class StationFacade
  def self.get_stations(location)
    stations_data = StationService.get_stations(location)
    stations = stations_data[:fuel_stations]

    stations.map do |station|
      Station.new(station)
    end
  end

  def self.get_station(id)
    station_data = StationService.get_station(id)
    ##Consider refactoring
    if station_data[:alt_fuel_station].present?
      latitude = station_data[:alt_fuel_station][:latitude]
      longitude = station_data[:alt_fuel_station][:longitude]
      weather_data = WeatherService.get_hourly_weather(latitude, longitude)
      StationDetails.new(station_data[:alt_fuel_station], weather_data)
    else
      station_data
    end
  end
end
