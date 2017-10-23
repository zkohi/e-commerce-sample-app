class AddCompanyRefToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :company, foreign_key: true
  end
end
