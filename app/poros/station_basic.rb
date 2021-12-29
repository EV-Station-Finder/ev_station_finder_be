class StationBasic
  attr_reader :id,
              :api_id,
              :name,
              :distance,
              :status,
              :hours,
              :ev_network,
              :street_address,
              :city,
              :state,
              :zip_code,
              :is_favorited

  def initialize(station_data, user_id=nil)
    @id             = nil
    @api_id         = station_data[:id].to_i # external api provides api_id as integer
                                             # but station api_id is saved as string in database
    @name           = station_data[:station_name]
    @distance       = station_data[:distance]
    @status         = status_finder(station_data[:status_code])
    @hours          = station_data[:access_days_time]
    @ev_network     = set_ev_network(station_data[:ev_network])
    @street_address = station_data[:street_address]
    @city           = station_data[:city]
    @state          = station_data[:state]
    @zip_code       = station_data[:zip]
    @is_favorited   = station_favorited?(station_data[:id], user_id)
  end

  def station_favorited?(station_api_id, user_id)
    return "User token not provided" if user_id.nil?
    User.find(user_id) # Check for users that do not exist to raise exception
    return false if (station = Station.find_by(api_id: station_api_id)).nil?
    if station && user_station = UserStation.find_by(station_id: station.id, user_id: user_id)
      user_station.favorited?
    else
      false
    end
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

  def set_ev_network(ev_network)
    if ev_network.nil?
      "Non-Networked"
    else
      ev_network
    end
  end
end
