class Api::V1::TokensController < ApplicationController
  before_action :set_user

  def create
    if @user.authenticate(user_params[:password])
      render json: { token: JsonWebToken.encode(user_id: @user.id), email: @user.email }
    else
      head :unauthorized
    end
  end

  private

  def set_user
    @user = User.find_by(email: user_params[:email])
    render json: { message: 'Can not find the user' }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
