class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_bad_request
  rescue_from JWT::DecodeError, with: :unauthorized_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def welcome; end

  private

  def record_bad_request(exception)
    render json: { errors: exception.message }, status: :bad_request
  end

  def unauthorized_user
    render json: { errors: "Unauthorized" }, status: :unauthorized
  end
  
  def record_not_found(exception)
    render json: { errors: "User not found" }, status: :not_found
  end
end
