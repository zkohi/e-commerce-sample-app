class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.integer :point, null: false

      t.timestamps
    end
  end
end
