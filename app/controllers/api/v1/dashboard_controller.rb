class Api::V1::DashboardController < ApplicationController
  def index
    address = format_user_address(get_user_details)
    nearest_stations = StationFacade.get_stations(address).first(3)
    favorite_stations = StationFacade.get_favorite_stations(get_user_stations)
    dashboard = Dashboard.new(get_user_details, nearest_stations, favorite_stations)
    render json: DashboardSerializer.new(dashboard)
  end

  private

  def find_user_by_id
    token = params[:token]
    decoded_token = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
    user_id = decoded_token[0]["user_id"]
    User.find(user_id)
  end

  def format_user_address(user)
    "#{user.street_address} #{user.city}, #{user.state} #{user.zip_code}"
  end

  def get_user_details
    user = find_user_by_id.attributes.except("password_digest")
    UserDetails.new(user)
  end

  def get_user_stations
    find_user_by_id.stations
  end
end
