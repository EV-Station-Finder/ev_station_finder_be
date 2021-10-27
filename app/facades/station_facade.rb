class StationFacade
  def self.get_stations(location)
    stations_data = StationService.get_stations(location)
    # TODO ADD Sad Path
    if stations_data[:errors]

    else
      stations = stations_data[:fuel_stations]
      stations.map do |station|
        StationBasic.new(station)
      end
    end
  end

  def self.get_favorite_stations(favorite_stations)
    stations = favorite_stations.map do |station|
      station_data = StationService.get_station(station.api_id)
      StationBasic.new(station_data[:alt_fuel_station])
    end
  end

  def self.get_station(id)
    station_data = StationService.get_station(id)
    # TODO: Consider refactoring
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
