class StationDetails
  attr_reader :id,
              :api_id,
              :name,
              :status,
              :hours,
              :ev_network,
              :street_address,
              :city,
              :state,
              :zip_code,
              :accepted_payments,
              :hourly_weather

  def initialize(station_data, weather_data)
    @id                = nil
    @api_id            = station_data[:id]
    @name              = station_data[:station_name]
    @status            = status_finder(station_data[:status_code])
    @hours             = station_data[:access_days_time]
    @ev_network        = station_data[:ev_network]
    @street_address    = station_data[:street_address]
    @city              = station_data[:city]
    @state             = station_data[:state]
    @zip_code          = station_data[:zip]
    @accepted_payments = station_data[:cards_accepted]
    @hourly_weather    = create_hourly_weather(weather_data)
  end

  def status_finder(code)
    if code.present?
      if code == 'E'
        'Available'
      elsif code == 'P'
        'Coming Soon'
      elsif code == 'T'
        'Temporarily Closed'
      end
    else
      'Status Unavailable'
    end
  end
  
  def create_hourly_weather(weather_data)
    current_and_hourly_weather = []
    current_and_hourly_weather << HourlyWeather.new(weather_data[:current])
    weather_data[:hourly].each do |weather|
      current_and_hourly_weather << HourlyWeather.new(weather)
    end
    current_and_hourly_weather.first(10)
  end
end
