class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      token = JWT.encode({user_id: user.id}, 'hasselhoff', 'HS256')
      render json: { data: { token: token, type: 'user' } }.to_json, status: 200
    else
      render json: { errors: "Invalid parameters" }, status: :bad_request
    end
  end

  def authorize
    token = params[:token]
    user_id = decode_token(params[:token])  
    user = User.find(user_id)
    render json: { data: { token: token, type: 'user' } }.to_json, status: 200
  end
end
