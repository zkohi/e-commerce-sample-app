class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :filename
      t.integer :price
      t.text :description
      t.boolean :flg_non_display
      t.integer :sort_order

      t.timestamps
    end
  end
end
