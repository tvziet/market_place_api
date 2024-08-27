class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]
  before_action :check_login, only: %i[create update destroy]
  before_action :check_owner, only: %i[update destroy]

  def index
    products = Product.includes(:user)
                      .page(params[:page])
                      .per(params[:per_page])
                      .search(params)
    pagination = get_links_serializer_options('api_v1_products_path', products)
    pagination[:include] = [:user]
    options = { serializer: ProductSerializer, pagination: }
    success_response(products, options)
  end

  def show
    success_response(set_product)
  end

  def create
    product = current_user.products.build(product_params)
    return errors_response(product.errors) unless product.save

    options = { status: :created }
    success_response(product, options)
  end

  def update
    return success_response(set_product) if set_product.update(product_params)

    errors_response(set_product.errors)
  end

  def destroy
    set_product.destroy
    head :no_content
  end

  private

  def set_product
    product = Product.find_by(id: params[:id])
    render json: { message: I18n.t('api.v1.products.not_found') }, status: :not_found unless product

    product
  end

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

  def check_owner
    head :forbidden if set_product.user_id != current_user.id
  end
end
