class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  include Gravtastic
  gravtastic
  
  validates :password, confirmation: true
  validates :email, :username, :password, :password_confirmation, :first_name, :last_name, :birth_date, :nationality, presence: true
  validates :email, :username, uniqueness: true
  validates :first_name, :last_name, format: {with: /\A[a-zA-Z]+\z/,  message: "only allows letters"}
  validates_date :birth_date, between: [Date.today - 14.years, Date.today - 100.years]
  


  # User-Friend Request association
  has_many :friend_requests_as_requestor, class_name: :FriendRequest, foreign_key: :requestor_id
  has_many :receivers, through: :friend_requests_as_requestor
  has_many :friend_requests_as_receiver, class_name: :FriendRequest, foreign_key: :receiver_id
  has_many :requestors, through: :friend_requests_as_receiver


  # User-Friend association
  has_many :friendships
  has_many :friends, through: :friendships

  # User-Posts association

  has_many :posts, dependent: :destroy

  # User-Likes association

  has_many :votes, class_name: :Like, dependent: :destroy

  # User-Comment association

  has_many :comments, dependent: :destroy

  # Profile pic. Active storage

  has_one_attached :avatar, dependent: :destroy

  def full_name
    first_name + " " + last_name
  end

  def nationality_name
    ISO3166::Country.find_country_by_alpha2(nationality).name
  end

end
