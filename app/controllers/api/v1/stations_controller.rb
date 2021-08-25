class Api::V1::StationsController < ApplicationController
  def show
  end

  def index
    stations = StationFacade.get_stations(params[:location])
    render json: StationSerializer.new(stations)
  rescue NoMethodError
    render json: { errors: "A valid location must be provided" }, status: :bad_request
  end
end
