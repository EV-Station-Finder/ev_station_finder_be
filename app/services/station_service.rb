class StationService
  def self.get_stations(location)
    response = conn.get("api/alt-fuel-stations/v1/nearest.json") do |faraday|
      faraday.params['fuel_type'] = 'ELEC'
      faraday.params['location'] = location
      faraday.params['ev_charging_level'] = 'dc_fast'
    end
    parse_json(response)
  end

  def self.get_station(id)
    response = conn.get("api/alt-fuel-stations/v1/#{id}.json")
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: "https://developer.nrel.gov") do |faraday|
      faraday.params['api_key'] = ENV['CHARGER_KEY']
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
