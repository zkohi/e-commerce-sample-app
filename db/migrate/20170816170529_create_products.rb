class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.name :string
      t.filename :string
      t.price :integer
      t.description :text
      t.flg_non_display :boolean
      t.sort_order :integer

      t.timestamps
    end
  end
end
