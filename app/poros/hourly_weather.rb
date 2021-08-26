class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(weather_data)
    # TODO: start here!
    @time        = weather_data[]
    @temperature = weather_data
    @conditions  = weather_data
    @icon        = weather_data
  end
end
