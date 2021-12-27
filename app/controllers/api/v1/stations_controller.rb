class Api::V1::StationsController < ApplicationController
  def index
    user_id = decode_token(search_params[:token]) if search_params[:token] != nil
    stations = StationFacade.get_stations(search_params[:location], user_id)
    render json: StationsSerializer.new(stations)
    rescue NoMethodError
      render json: { errors: "A valid location must be provided" }, status: :bad_request
  end

  def show
    station = StationFacade.get_station(search_params[:id])
    if station.class == StationDetails
      render json: StationSerializer.new(station)
    else
      render json: { errors: "Cannot find station with ID #{search_params[:id]}" }, status: :bad_request
    end
  end

private
  
  def search_params
    params.permit(:token, :location, :id)
  end
end

