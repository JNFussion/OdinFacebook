class Comment < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :user_id
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  

  def find_post
    parent_comment = commentable
    while !parent_comment.is_a?(Post)
      parent_comment = parent_comment.commentable
    end
    parent_comment
  end
end
