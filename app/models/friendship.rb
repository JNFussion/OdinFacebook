class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  validates :user, uniqueness: { scope: :friend }
  validate :not_self_friendship

  def not_self_friendship
    if user == friend
      errors.add(:base,"You cannot be friend with yourself.")
    end
  end
end
