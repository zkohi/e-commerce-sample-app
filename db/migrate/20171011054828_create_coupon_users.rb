class CreateCouponUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :coupon_users do |t|
      t.references :coupon, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :point, null: false

      t.timestamps
    end
  end
end
