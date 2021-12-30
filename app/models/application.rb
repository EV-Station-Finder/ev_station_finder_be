module  Stationable
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
  
  def status_finder(status_code)
    if status_code.present?
      if status_code == 'E'
        'Available'
      elsif status_code == 'P'
        'Coming Soon'
      elsif status_code == 'T'
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