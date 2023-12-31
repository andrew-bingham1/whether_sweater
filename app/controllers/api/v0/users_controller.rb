class Api::V0::UsersController < ApplicationController
  wrap_parameters :user, include: [:email, :password, :password_confirmation]
  
  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex(10)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end