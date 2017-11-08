class AddOrderIdToUserPoints < ActiveRecord::Migration[5.1]
  def change
    add_column :user_points, :order_id, :integer

    add_index :user_points, :order_id
  end
end
