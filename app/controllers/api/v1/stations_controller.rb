class Api::V1::StationsController < ApplicationController
  def index
# require "pry";binding.pry
    stations = StationFacade.get_stations(search_location[:location])
    render json: StationsSerializer.new(stations)
  rescue NoMethodError
    render json: { errors: "A valid location must be provided" }, status: :bad_request
  end

  def show
    station = StationFacade.get_station(station_api_id[:id])
    if station.class == StationDetails
      render json: StationSerializer.new(station)
    else
      render json: { errors: "Cannot find station with ID #{station_api_id[:id]}" }, status: :bad_request
    end
  end

private

  def station_api_id
    params.permit(:id)
  end

  def search_location
    params.permit(:location)
  end
  
  # def station_params
  #   params.permit(:token, :api_id)
  # end
end

