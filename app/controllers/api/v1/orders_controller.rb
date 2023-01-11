class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show]
  before_action :set_order, only: %i[show]

  def index
    render json: OrderSerializer.new(current_user.orders).serializable_hash
  end

  def show
    options = { include: [:products] }
    render json: OrderSerializer.new(@order, options).serializable_hash
  end

  private

  def set_order
    @order = current_user.orders.find_by(id: params[:id])
    return render json: { message: "Can not find the order" }, status: :not_found unless @order
  end
end
