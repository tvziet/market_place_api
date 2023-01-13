require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @order_params = { order: { product_ids: [products(:one).id, products(:two).id], total: 50 } }
  end

  # Index action
  test "should forbid orders for unlogged" do
    get api_v1_orders_url, as: :json
    assert_response :forbidden
  end

  test "should show orders" do
    get api_v1_orders_url, headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) }, as: :json
    assert_response :success

    json_response = JSON.parse(response.body, symbolize_names: true)
    assert_json_response_is_paginated json_response
    assert_equal @order.user.orders.count, json_response.dig(:data).count
  end

  # Show action
  test "should forbid show order" do
    get api_v1_order_url(@order), as: :json
    assert_response :forbidden
  end

  test "should show order with the exists ID" do
    get api_v1_order_url(@order), headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) }, as: :json
    assert_response :success

    json_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal @order.products.first.title, json_response.dig(:included, 0, :attributes, :title)
  end

  test "should not show the order with the not exists ID" do
    get api_v1_order_url(111), headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) }, as: :json
    assert_response :not_found
  end

  # Create action
  test "should forbid create order for unlogged" do
    assert_no_difference("Order.count") do
      post api_v1_orders_url, params: @order_params,
                              as: :json
    end
    assert_response :forbidden
  end

  test "should create order with two products" do
    assert_difference("Order.count", 1) do
      post api_v1_orders_url, params: @order_params,
                              headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) },
                              as: :json
    end
    assert_response :created
  end
end
