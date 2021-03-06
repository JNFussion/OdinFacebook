class Like < ApplicationRecord
  enum vote: {liked: "liked", disliked: "disliked"}
  
  belongs_to :user
  belongs_to :post

  validates :post, :user, presence: true
  validates :post, uniqueness: { scope: :user }
  validates :vote, inclusion: { in: votes.keys }

  after_save :update_votes_counter
  after_destroy :update_votes_counter

  def update_votes_counter
    post.likes_count = post.likes.count
    post.dislikes_count = post.dislikes.count

    post.save
  end
end
