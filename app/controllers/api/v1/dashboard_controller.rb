class Api::V1::DashboardController < ApplicationController
  def index
    user = find_user_by_id
    user_details = UserDetails.new(user.attributes)
    address = format_user_address(user_details)
    nearest_stations = StationFacade.get_stations(address).first(3)
    favorite_stations = StationFacade.get_favorite_stations(user.stations)
    dashboard = Dashboard.new(user_details, nearest_stations, favorite_stations)
    render json: DashboardSerializer.new(dashboard)
  end

  private

  def find_user_by_id # should find/return user model?
    token = params[:token]
    decoded_token = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
    user_id = decoded_token[0]["user_id"]
    User.find(user_id)
    # user = User.find(user_id)
    # UserDetails.new(user.attributes)
  end

  def format_user_address(user)
    "#{user.street_address} #{user.city}, #{user.state} #{user.zip_code}"
  end
end
