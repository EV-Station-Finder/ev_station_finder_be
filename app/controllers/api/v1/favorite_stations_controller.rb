class Api::V1::FavoriteStationsController < ApplicationController
  def index
    user_id = decode_token(station_params[:token])
    user = User.find(user_id)
    favorite_stations = Station.find_favorite_stations(user)
    if favorite_stations.empty?
      render json: { errors: "User has no favorite stations" }, status: :unprocessable_entity
    else
      favorite_stations_data = StationFacade.get_favorite_stations(favorite_stations, user_id)
      render json: StationsSerializer.new(favorite_stations_data)
    end
  end

  def create
    user_id = decode_token(station_params[:token])
    user = User.find(user_id)
    station = Station.where(api_id: station_params[:api_id]).first_or_create!
    if (user_station = UserStation.find_by(user_id: user.id, station_id: station.id))
      if user_station.is_favorited
        render json: { errors: "User has already favorited station with api ID: #{station_params[:api_id]}" }, status: :unprocessable_entity
      else
        user_station.update(is_favorited: true)
        render json: { data: { type: 'favorite_station' } }, status: 201
      end
    else
      favorite_station = UserStation.create!(station_id: station.id, user_id: user.id)
      render json: { data: { type: 'favorite_station' } }, status: 201
    end
  end
  
  def destroy
    user_id = decode_token(station_params[:token])
    station = Station.find_by!(api_id: station_params[:api_id])
    user_station = UserStation.find_by!(user_id: user_id, station_id: station.id)
    if user_station.is_favorited
      user_station.update(is_favorited: false)
    else
      render json: { errors: "FavoriteStation not found" }, status: :not_found
    end
  end

  private

  def station_params
    params.permit(:token, :api_id)
  end
end
