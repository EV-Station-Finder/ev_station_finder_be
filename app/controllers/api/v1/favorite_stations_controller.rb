class Api::V1::FavoriteStationsController < ApplicationController
  def index
    token = params[:token]
    decoded_token = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
    user_id = decoded_token[0]["user_id"]
    user = User.find(user_id)
    if user.stations.empty?
      render json: { errors: "User has no favorite stations" }, status: :unprocessable_entity
    else
      favorite_stations = StationFacade.get_favorite_stations(user.stations)
      render json: StationsSerializer.new(favorite_stations)
    end
  end
end
