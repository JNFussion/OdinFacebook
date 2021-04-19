class FriendRequest < ApplicationRecord
  enum status: {pending: "pending", accepted: "accepted"}, _default: :pending
  
  after_update :create_friends
  
  validate :not_self_request, :not_request_as_receiver, :already_friends
  validates :status, inclusion: { in: statuses.keys }
  validates :requestor_id, :receiver_id, presence: true
  
  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User

  def create_friends
    requestor.friends << receiver
    receiver.friends << requestor
    self.destroy
  end

  def not_self_request
    if requestor == receiver
      errors.add(:base,"You cannot sent a request to yourself.")
    end
  end

  def not_request_as_receiver
    if requestor.requestors.include?(receiver)
      errors.add(:base, "That person has already sent you a request.")
    end
  end

  def already_friends
    if requestor.friends.include?(receiver)
      errors.add(:base, "You are alreay friend with that person.")
    end
  end

end
