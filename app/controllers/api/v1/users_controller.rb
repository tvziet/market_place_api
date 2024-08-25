class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]

  def show
    options = { include: [:products] }
    render json: UserSerializer.new(@user, options).serializable_hash
  end

  def create
    @user = User.new(user_params)
    return render json: { errors: @user.errors }, status: :unprocessable_entity unless @user.save

    render json: UserSerializer.new(@user).serializable_hash, status: :created
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { message: I18n.t('api.v1.users.not_found') }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end
end
