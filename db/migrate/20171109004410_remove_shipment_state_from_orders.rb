class RemoveShipmentStateFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :shipment_state, :integer
  end
end
