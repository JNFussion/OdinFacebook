class Post < ApplicationRecord
  
  validates :author, :content, presence: true
  
  belongs_to :author, class_name: :User, foreign_key: :user_id

  has_many :votes, class_name: :Like, dependent: :destroy
  has_many :likes, -> { liked }, class_name: :Like
  has_many :dislikes, -> { disliked }, class_name: :Like

  has_many :comments, as: :commentable, dependent: :destroy

end
