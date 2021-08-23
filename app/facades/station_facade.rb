class StationFacade
  def self.get_stations(location)
    stations_data = StationService.get_stations(location)
    stations = stations_data[:fuel_stations]

    stations.map do |station|
      Station.new(station)
    end
  end
end
