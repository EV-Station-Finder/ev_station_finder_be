class WeatherService
  def self.get_hourly_weather(latitude, longitude)
    response = conn.get('/data/2.5/onecall') do |faraday|
          faraday.params['lat'] = latitude
          faraday.params['lon'] = longitude
          faraday.params['units'] = 'imperial'
          faraday.params['exclude'] = 'minutely,daily,alerts'
    end
    parse_json(response)
  end

  def self.conn
    Faraday.new(url: "https://api.openweathermap.org") do |faraday|
      faraday.params['appid'] = ENV['WEATHER_KEY']
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
