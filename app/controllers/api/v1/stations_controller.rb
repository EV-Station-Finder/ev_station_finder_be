class Api::V1::StationsController < ApplicationController
  def index
    stations = StationFacade.get_stations(search_location)
    render json: StationsSerializer.new(stations)
  rescue NoMethodError
    render json: { errors: "A valid location must be provided" }, status: :bad_request
  end
  
  def show
    station = StationFacade.get_station(station_api_id)
    # TODO: add weather facade which will need coordinates (?)
    render json: StationSerializer.new(station)
    rescue NoMethodError
      render json: { errors: "Cannot find station with ID #{station_api_id}" }, status: :bad_request
  end


private

  def station_api_id
    api_id = params.permit(:id)
    api_id[:id]
  end

  def search_location
    search_location = params.permit(:location)
    search_location[:location]
  end
end
