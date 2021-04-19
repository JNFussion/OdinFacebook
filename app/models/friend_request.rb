class FriendRequest < ApplicationRecord
  enum status: {pending: "pending", accepted: "accepted"}, _default: :pending
  after_update :create_friends

  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  def create_friends
    requestor.friends << receiver
    receiver.friends << requestor
  end
end
