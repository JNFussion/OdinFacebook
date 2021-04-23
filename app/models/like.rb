class Like < ApplicationRecord
  enum vote: {liked: "liked", disliked: "disliked"}
  
  belongs_to :user
  belongs_to :post

  validates :post, :user, presence: true
  validates :post, uniqueness: { scope: :user }
  validates :vote, inclusion: { in: votes.keys }
end
