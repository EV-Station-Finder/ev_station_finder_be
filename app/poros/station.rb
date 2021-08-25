class Station
  attr_reader :id,
              :name,
              :distance,
              :status,
              :hours,
              :ev_network,
              :street_address,
              :city,
              :state,
              :zip_code

  def initialize(station_data)
    @id             = nil
    @name           = station_data[:station_name]
    @distance       = station_data[:distance]
    @status         = status_finder(station_data[:status_code])
    @hours          = station_data[:access_days_time]
    @ev_network     = station_data[:ev_network]
    @street_address = station_data[:street_address]
    @city           = station_data[:city]
    @state          = station_data[:state]
    @zip_code       = station_data[:zip]
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
end
