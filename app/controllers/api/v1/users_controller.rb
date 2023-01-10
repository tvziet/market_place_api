class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    render json: @user
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return render json: { message: "Can not find the user" }, status: :not_found unless @user
  end
end

