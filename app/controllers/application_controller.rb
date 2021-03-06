class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_bad_request
  rescue_from JWT::DecodeError, with: :unauthorized_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def decode_token(token)
    decoded_token = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
    decoded_token[0]["user_id"]
  end

  private

  def record_bad_request(exception)
    render json: { errors: exception.message }, status: :bad_request
  end

  def unauthorized_user
    render json: { errors: "Unauthorized" }, status: :unauthorized
  end
  
  def record_not_found(exception)
    if exception.model == "UserStation"
      render json: { errors: "FavoriteStation not found" }, status: :not_found
    else
      render json: { errors: "#{exception.model} not found" }, status: :not_found
    end
  end
end
