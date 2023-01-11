class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show create]
  before_action :set_order, only: %i[show]

  def index
    render json: OrderSerializer.new(current_user.orders).serializable_hash
  end

  def show
    options = { include: [:products] }
    render json: OrderSerializer.new(@order, options).serializable_hash
  end

  def create
    order = current_user.orders.build(order_params)
    if order.save
      render json: OrderSerializer.new(order).serializable_hash, status: :created
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:total, product_ids: [])
  end

  def set_order
    @order = current_user.orders.find_by(id: params[:id])
    return render json: { message: "Can not find the order" }, status: :not_found unless @order
  end
end
