class AddColumnToLike < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :vote, :string
  end
end
