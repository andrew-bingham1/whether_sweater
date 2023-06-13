class Api::V0::SessionsController < ApplicationController
  wrap_parameters :session, include: [:email, :password]
  
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { errors: 'Bad Credentials' }, status: :unauthorized
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end