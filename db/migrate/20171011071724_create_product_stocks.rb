class CreateProductStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :product_stocks do |t|
      t.references :product, foreign_key: true
      t.references :company, foreign_key: true
      t.integer :stock, null: false

      t.timestamps
    end
  end
end
