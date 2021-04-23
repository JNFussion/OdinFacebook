class Post < ApplicationRecord
  
  validates :author, :content, presence: true
  
  belongs_to :author, class_name: :User, foreign_key: :user_id

  has_many :likes, dependent: :destroy
end
