class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_bad_request
  rescue_from JWT::DecodeError, with: :not_logged_in
  def welcome; end

  private

  def record_bad_request(exception)
    render json: { errors: exception.message }, status: :bad_request
  end

  def not_logged_in
    render json: { errors: "Not logged in" }, status: 401
  end
end
