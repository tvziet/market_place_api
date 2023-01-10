class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    return render json: user.errors, status: :unprocessable_entity unless user.save

    render json: user, status: :created
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return render json: { message: "Can not find the user" }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

