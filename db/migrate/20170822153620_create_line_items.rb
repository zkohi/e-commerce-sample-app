class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.references :order, foreign_key: true
      t.references :product, index: true
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
