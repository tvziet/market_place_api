class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]
  before_action :check_login, only: %i[create update destroy]
  before_action :check_owner, only: %i[update destroy]

  def index
    products = Product.all
    render json: products
  end

  def show
    render json: @product
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    return render json: { message: "Can not find the product" }, status: :not_found unless @product
  end

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

  def check_owner
    head :forbidden if @product.user_id != current_user.id
  end
end

