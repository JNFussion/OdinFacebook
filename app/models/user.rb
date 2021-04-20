class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # User-Friend Request association
  has_many :friend_requests_as_requestor, class_name: :FriendRequest, foreign_key: :requestor_id
  has_many :receivers, through: :friend_requests_as_requestor
  has_many :friend_requests_as_receiver, class_name: :FriendRequest, foreign_key: :receiver_id
  has_many :requestors, through: :friend_requests_as_receiver


  # User-Friend association
  has_many :friendships
  has_many :friends, through: :friendships

  def full_name
    first_name + " " + last_name
  end

  def nationality_name
    ISO3166::Country.find_country_by_alpha2(nationality).name
  end

end
