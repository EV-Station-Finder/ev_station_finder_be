class Api::V1::UsersController < ApplicationController
  # def new
  #   @user = User.new
  # end

  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  private

  def user_params
    params[:email] = params[:email].downcase
    params.permit(:first_name, :last_name, :email, :street_address, :city, :state, :zip_code, :password)
  end
end
