class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]

  def show
    success_response(set_user)
  end

  def create
    user = User.new(user_params)
    return errors_response(user.errors) unless user.save

    options = { status: :created }

    success_response(user, options)
  end

  def update
    return success_response(set_user) if set_user.update(user_params)

    errors_response(set_user.errors)
  end

  def destroy
    set_user.destroy
    head :no_content
  end

  private

  def set_user
    user = User.find_by(id: params[:id])
    return render json: { message: I18n.t('api.v1.users.not_found') }, status: :not_found unless user

    user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def check_owner
    head :forbidden unless set_user.id == current_user&.id
  end
end
