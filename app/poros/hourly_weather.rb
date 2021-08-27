class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(weather_data)
    @time        = seconds_to_hour_minutes(weather_data[:dt])
    @temperature = weather_data[:temp]
    @conditions  = weather_data[:weather][0][:description]
    @icon        = weather_data[:weather][0][:icon]
  end
  
  def seconds_to_hour_minutes(seconds)
    format("%02d:%02d:%02d", seconds / 3600, seconds / 60 % 60, seconds % 60)
  end
end
