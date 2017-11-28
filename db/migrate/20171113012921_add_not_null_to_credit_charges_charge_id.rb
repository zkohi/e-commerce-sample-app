class AddNotNullToCreditChargesChargeId < ActiveRecord::Migration[5.1]
  def change
    change_column_null :credit_charges, :charge_id, false
  end
end
