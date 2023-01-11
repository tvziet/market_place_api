class CreatePlacements < ActiveRecord::Migration[6.1]
  def change
    create_table :placements do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
