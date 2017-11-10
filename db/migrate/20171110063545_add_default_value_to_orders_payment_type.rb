class AddDefaultValueToOrdersPaymentType < ActiveRecord::Migration[5.1]
  def change
    change_column_default :orders, :payment_type, 0
  end
end
