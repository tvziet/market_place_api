require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  # Show action
  test "should show product with the exists ID" do
    get api_v1_product_url(@product), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @product.title, json_response["data"]["attributes"]["title"]
  end

  test "should not show the product with the not exists ID" do
    get api_v1_product_url(111), as: :json
    assert_response :not_found
  end

  # Index action
  test "should show list products" do
    get api_v1_products_url, as: :json
    assert_response :success
  end

  # Create action
  test "should create product" do
    assert_difference("Product.count") do
      post api_v1_products_url, params: { product: { title: @product.title,
                                                    price: @product.price,
                                                    published: @product.published } },
                                headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) },
                                as: :json
    end
    assert_response :created
  end

  test "should forbid create product" do
    assert_no_difference("Product.count") do
      post api_v1_products_url, params: { product: { title: @product.title,
                                                    price: @product.price,
                                                    published: @product.published } },
                                as: :json
    end
    assert_response :forbidden
  end

  # Update action
  test "should update product" do
    patch api_v1_product_url(@product), params: { product: { title: @product.title } },
                                        headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) },
                                        as: :json
    assert_response :success
  end

  test "should forbid update product" do
    patch api_v1_product_url(@product), params: { product: { title: @product.title } },
                                        as: :json
    assert_response :forbidden
  end

  test "should not update product with invalid params" do
    patch api_v1_product_url(@product), params: { product: { title: nil } },
                                        headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) },
                                        as: :json
    assert_response :unprocessable_entity
  end

  # Destroy action
  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete api_v1_product_url(@product), headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) }, as: :json
    end
    assert_response :no_content
  end

  test "should forbid destroy product" do
    assert_no_difference("Product.count") do
      delete api_v1_product_url(@product), as: :json
    end
    assert_response :forbidden
  end

  test "should not destroy product with the user is not owner of the product" do
    assert_no_difference("Product.count") do
      delete api_v1_product_url(@product), headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    end
    assert_response :forbidden
  end
end
