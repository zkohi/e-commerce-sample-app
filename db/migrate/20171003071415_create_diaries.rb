class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true
      t.text :content, null: false
      t.string :img_filename

      t.timestamps
    end
  end
end
