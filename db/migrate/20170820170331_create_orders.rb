class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :state, null: false, default: 0
      t.integer :shipment_state, null: false, default: 0
      t.integer :payment_state, null: false, default: 0
      t.integer :item_count, null: false, default: 0
      t.integer :item_total, null: false, default: 0
      t.integer :shipment_total, null: false, default: 0
      t.integer :payment_total, null: false, default: 0
      t.integer :adjustment_total, null: false, default: 0
      t.integer :tax_total, null: false, default: 0
      t.integer :total, null: false, default: 0
      t.date :shipping_date
      t.string :shipping_time_range_string
      t.string :user_name
      t.string :user_address

      t.timestamps
    end
  end
end
