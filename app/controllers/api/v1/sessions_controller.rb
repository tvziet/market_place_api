class Api::V1::SessionsController < ApplicationController
  before_action :set_user

  def create
    return render json: { token: JsonWebToken.encode(user_id: set_user.id) } \
      if set_user.authenticate(user_params[:password])

    head :unauthorized
  end

  private

  def set_user
    user = User.find_by(email: user_params[:email])
    return render json: { message: I18n.t('api.v1.users.not_found') }, status: :not_found unless user

    user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
