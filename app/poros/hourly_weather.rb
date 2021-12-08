class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(weather_data)
    @time        = unix_time_to_hour_minutes(weather_data[:dt])
    @temperature = weather_data[:temp]
    @conditions  = weather_data[:weather][0][:description]
    @icon        = weather_data[:weather][0][:icon]
  end

  def unix_time_to_hour_minutes(unix_time)
    Time.at(unix_time.to_i).strftime("%H:%M %Z")
  end
end
