class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      record.errors[product.title.to_s] << "Is out of stock, just #{product.quantity} left" if placement.quantity > product.quantity
    end
  end
end
