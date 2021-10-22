class Api::V1::DashboardController < ApplicationController
  def index
    user = find_user_by_id
    address = format_user_address(user)
    nearest_stations = StationFacade.get_stations(address).first(3)
    favorite_stations = StationFacade.get_favorite_stations(user.stations)
    dashboard = Dashboard.new(user, nearest_stations, favorite_stations)
    render json: DashboardSerializer.new(dashboard) #TODO: make the ID nil in the poro
  end

  private

  def find_user_by_id
    token = params[:token]
    decoded_token = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
    user_id = decoded_token[0]["user_id"]
    user = User.find(user_id)
    UserDetails.new(user.attributes)
  end

  def format_user_address(user)
    "#{user.street_address} #{user.city}, #{user.state} #{user.zip_code}"
  end
end
