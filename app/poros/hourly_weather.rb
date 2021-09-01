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
  
  def unix_time_to_hour_minutes(unix_time) # double check it's actually in Unix time
    DateTime.strptime(unix_time.to_s, '%s').strftime("%H:%M")
    #Time.at(seconds).strftime("%H:%M") # Alternate for local time - investigate later
  end
end
