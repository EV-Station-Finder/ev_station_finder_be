class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_bad_request
  def welcome; end

  private

  def record_bad_request(exception)
    render json: { errors: exception.message }, status: :bad_request
  end
end
