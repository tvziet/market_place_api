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
    permitted_params = %i[email password]

    if action_name == 'create'
      params.require(:user).permit(*permitted_params)
    else
      permitted_params << :avatar
      params.permit(*permitted_params)
    end
  end

  def check_owner
    head :forbidden unless set_user.id == current_user&.id
  end
end
