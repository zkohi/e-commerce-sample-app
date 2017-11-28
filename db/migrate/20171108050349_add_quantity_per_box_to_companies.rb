class AddQuantityPerBoxToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :quantity_per_box, :integer, null: false
  end
end
