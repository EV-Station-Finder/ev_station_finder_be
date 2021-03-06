require "./app/models/application.rb"

class StationDetails
  include Stationable
  
  attr_reader :id,
              :api_id,
              :name,
              :status,
              :hours,
              :ev_connector_types,
              :ev_network,
              :street_address,
              :city,
              :state,
              :zip_code,
              :is_favorited,
              :accepted_payments,
              :hourly_weather

  def initialize(station_data, weather_data, user_id=nil)
    @id                 = nil
    @api_id             = station_data[:id]
    @name               = station_data[:station_name]
    @status             = status_finder(station_data[:status_code])
    @hours              = station_data[:access_days_time]
    @ev_connector_types = station_data[:ev_connector_types]
    @ev_network         = set_ev_network(station_data[:ev_network])
    @street_address     = station_data[:street_address]
    @city               = station_data[:city]
    @state              = station_data[:state]
    @zip_code           = station_data[:zip]
    @is_favorited       = station_favorited?(station_data[:id], user_id)
    @accepted_payments  = format_payments(station_data)
    @hourly_weather     = create_hourly_weather(weather_data)
  end

  def format_payments(station_data)
    accepted_payments = station_data[:cards_accepted]
    formatted_payments = []
    if accepted_payments.nil? && station_data[:ev_network] == "Tesla"
      formatted_payments << "Tesla Payment Network"
    elsif accepted_payments.present?
      rename_payment_methods(accepted_payments, formatted_payments)
    else
      formatted_payments =["No Payment Options Available"] # cards_accepted = nil, [],  or the hashkey itself does not exist
    end
    only_less_popular_payment_methods_available(formatted_payments)
  end

  def rename_payment_methods(accepted_payments, formatted_payments)
    accepted_payment_codes = accepted_payments.split(" ")
    formatted_payments << "American Express" if accepted_payment_codes.include?("A")
    formatted_payments << "Discover" if accepted_payment_codes.include?("D")
    formatted_payments << "MasterCard" if accepted_payment_codes.include?("M")
    formatted_payments << "Visa" if accepted_payment_codes.include?("V")
    formatted_payments << "Cash" if accepted_payment_codes.include?("Cash")
    formatted_payments << "Apple Pay" if accepted_payment_codes.include?("APPLE_PAY")
    formatted_payments << "Android Pay" if accepted_payment_codes.include?("ANDROID_PAY")
  end

  def only_less_popular_payment_methods_available(formatted_payments)
    if formatted_payments.empty? #If defined payments are not available, but other payment forms are present
      formatted_payments =["Payment Information Unavailable"]
    else
      formatted_payments
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
