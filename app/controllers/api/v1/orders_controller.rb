class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show create]
  before_action :set_order, only: %i[show]

  def index
    orders = current_user.orders
                         .page(params[:page])
                         .per(params[:per_page])
    options = get_links_serializer_options('api_v1_orders_path', orders)
    render json: OrderSerializer.new(orders, options).serializable_hash
  end

  def show
    options = { include: [:products] }
    render json: OrderSerializer.new(@order, options).serializable_hash
  end

  def create
    order = current_user.orders.build(order_params)
    if order.save
      OrderMailer.send_confirmation(order).deliver_later
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
    render json: { message: I18n.t('api.v1.orders.not_found') }, status: :not_found unless @order
  end
end
