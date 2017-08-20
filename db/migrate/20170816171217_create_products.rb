class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :filename, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.boolean :flg_non_display, null: false
      t.integer :sort_order, null: false

      t.timestamps
    end
  end
end
