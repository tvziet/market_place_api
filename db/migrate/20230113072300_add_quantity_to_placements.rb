class AddQuantityToPlacements < ActiveRecord::Migration[6.1]
  def change
    add_column :placements, :quantity, :integer, null: false, default: 0
  end
end
