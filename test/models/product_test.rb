# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  price      :decimal(, )      not null
#  published  :boolean          default(FALSE)
#  quantity   :integer          default(0), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # Validations
  test "product with negative price should be invalid" do
    product = products(:one)
    product.price = -1
    assert product.invalid?
  end

  test "product has null price should be invalid" do
    product = products(:one)
    product.price = nil
    assert product.invalid?
  end

  test "product has null title should be invalid" do
    product = products(:one)
    product.title = nil
    assert product.invalid?
  end

  test "product does not reference to an user should be invalid" do
    product = products(:one)
    product.user_id = nil
    assert product.invalid?
  end

  # Filter products by title, price, by created_at
  test "should filter products by title" do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test "should filter products by title and sort them" do
    assert_equal [products(:another_tv), products(:one)], Product.filter_by_title('tv').sort
  end

  test "should filter products by price above and sort them" do
    assert_equal [products(:two), products(:one)], Product.above_or_equal_to_price(200).sort
  end

  test "should filter products by price lower and sort them" do
    assert_equal [products(:another_tv)], Product.below_or_equal_to_price(200).sort
  end

  test "should sort products by most recent" do
    products(:another_tv).touch
    assert_equal [products(:another_tv), products(:one), products(:two)], Product.recent.to_a
  end

  # Search engine
  test "search should not find 'videogame' as title and '100' as min price" do
    search_hash = { title: "videogame", min_price: 100 }
    assert Product.search(search_hash).empty?
  end

  test "search should find 'tv' with range of price" do
    search_hash = { title: "tv", min_price: 50, max_price: 150 }
    assert_equal [products(:another_tv)], Product.search(search_hash)
  end

  test "search should filter products by product ids" do
    search_hash = { product_ids: [products(:one)] }
    assert_equal [products(:one)], Product.search(search_hash)
  end

  test "should get all products when no parameters" do
    assert_equal Product.all.to_a, Product.search({})
  end
end
