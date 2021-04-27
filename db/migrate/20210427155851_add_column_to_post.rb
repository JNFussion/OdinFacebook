class AddColumnToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :likes_count, :bigint
    add_column :posts, :dislikes_count, :bigint

    Post.all.each do |p|
      Post.update_counters p.id, :likes_count => p.likes.count, :dislikes_count => p.dislikes.count
    end
  end
end
