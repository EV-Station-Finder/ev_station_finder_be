class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    token = JWT.encode({user_id: user.id}, 'hasselhoff', 'HS256')
    render json: { data: { token: token, type: 'user' } }.to_json, status: 201
  end

  def show
    user_id = decode_token(params[:token])
    user = User.find(user_id)
    render json: UserSerializer.new(user)
  end
  
  def destroy
    user_id = decode_token(params[:token])
    User.destroy(user_id)
  end
  
  def update
    user_id = decode_token(params[:token])
    user = User.find(user_id)
    user.update!(user_params)
    render json: UserSerializer.new(user)
  end

  private

  def user_params
    params[:email] = params[:email].downcase
    params.permit(:first_name, :last_name, :email, :street_address, :city, :state, :zip_code, :password)
  end
end
