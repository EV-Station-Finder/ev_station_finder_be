class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      token = JWT.encode({user_id: user.id}, 'hasselhoff', 'HS256')
      # user_id = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
      render json: { data: { token: token, type: 'user' } }.to_json, status: 200
    else
      render json: { errors: "Invalid parameters" }, status: :bad_request
    end
  end
end
