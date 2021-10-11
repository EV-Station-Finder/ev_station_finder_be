class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    token = JWT.encode({user_id: user.id}, 'hasselhoff', 'HS256')
    # user_id = JWT.decode(token, 'hasselhoff', true, {algorithm: 'HS256'})
    render json: { data: { token: token, type: 'user' } }.to_json, status: 201
  end

  private

  def user_params
    params[:email] = params[:email].downcase
    params.permit(:first_name, :last_name, :email, :street_address, :city, :state, :zip_code, :password)
  end
end
