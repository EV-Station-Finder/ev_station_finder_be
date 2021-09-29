class ApplicationController < ActionController::API
  def welcome
  end
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_bad_request

  private

  def record_not_found
    render json: { errors: "No record found for given ID" }, status: :not_found
  end

  def record_bad_request(exception)
    render json: { errors: exception.message }, status: :bad_request
  end
end
