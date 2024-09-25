class Api::V1::SessionsController < ApplicationController
  before_action :set_user

  def create
    if @user.authenticate(user_params[:password])
      render json: { token: JsonWebToken.encode(user_id: @user.id) }
    else
      head :unauthorized
    end
  end

  private

  def set_user
    @user = User.find_by(email: user_params[:email])
    render json: { message: I18n.t('api.v1.users.not_found') }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
