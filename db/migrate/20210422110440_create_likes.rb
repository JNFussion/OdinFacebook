class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :post
      t.references :user
      t.index [:post_id, :user_id], :unique => true
      t.timestamps
    end
  end
end
