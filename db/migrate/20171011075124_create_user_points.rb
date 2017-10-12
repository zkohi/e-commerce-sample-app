class CreateUserPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :user_points do |t|
      t.references :user, foreign_key: true
      t.integer :coupon_id
      t.integer :status, null: false
      t.integer :point, null: false

      t.timestamps
    end

    add_index :user_points, :coupon_id
  end
end
