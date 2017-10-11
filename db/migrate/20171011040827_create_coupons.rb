class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false, unique: true
      t.integer :point, null: false

      t.timestamps
    end

    add_index :coupons, :code, :unique => true
  end
end
