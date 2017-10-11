class AddImgFilenameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :img_filename, :string
  end
end
