class AddColumnUrlPhotoToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :url_photo, :string
  end
end
