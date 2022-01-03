class Api::V1::FavoriteStationsController < ApplicationController
  def index
    user_id = decode_token(station_params[:token])
    user = User.find(user_id)
    if user.stations.empty?
      render json: { errors: "User has no favorite stations" }, status: :unprocessable_entity
    else
      favorite_stations = StationFacade.get_favorite_stations(user.stations)
      render json: StationsSerializer.new(favorite_stations)
    end
  end

  def create
    user_id = decode_token(station_params[:token])
    user = User.find(user_id)
    station = Station.where(api_id: station_params[:api_id]).first_or_create!
    if UserStation.exists?(station_id: station.id, user_id: user.id)
      render json: { errors: "User has already favorited station with api ID: #{station_params[:api_id]}" }, status: :unprocessable_entity
    else
      favorite_station = UserStation.create!(station_id: station.id, user_id: user.id)
      render json: { data: { type: 'favorite_station' } }, status: 201
    end
  end
  
  def destroy
    user_id = decode_token(station_params[:token])
    station = Station.find_by(api_id: station_params[:api_id])
    user_station = UserStation.find_by(station_id: station.id, user_id: user_id)
    user_station.update!(favorited?: false)
  end

  private

  def station_params
    params.permit(:token, :api_id)
  end
end
