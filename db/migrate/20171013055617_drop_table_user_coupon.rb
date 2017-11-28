class DropTableUserCoupon < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_coupons
  end
end
