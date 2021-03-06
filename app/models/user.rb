class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  
  include Gravtastic
  gravtastic
  
  validates :password, confirmation: true
  validates :email, :username, :first_name, :last_name, :birth_date, :nationality, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, :password_confirmation, presence: false, on: :update
  validates :email, :username, uniqueness: true
  validates :first_name, :last_name, format: {with: /\A[a-zA-Z]+\z/,  message: "only allows letters"}
  validates :avatar,
            content_type: [:png, :jpg, :jpeg],
            size: { less_than: 2.megabytes , message: 'must be less than 2MB in size' }
  validate :password_complexity

  after_create :send_welcome_email
  before_destroy :remove_friends, :update_comments

  # User-Friend Request association
  has_many :friend_requests_as_requestor, class_name: :FriendRequest, foreign_key: :requestor_id
  has_many :receivers, through: :friend_requests_as_requestor, dependent: :destroy
  has_many :friend_requests_as_receiver, class_name: :FriendRequest, foreign_key: :receiver_id
  has_many :requestors, through: :friend_requests_as_receiver, dependent: :destroy


  # User-Friend association
  has_many :friendships
  has_many :friends, through: :friendships

  # User-Posts association

  has_many :posts, dependent: :destroy

  # User-Likes association

  has_many :votes, class_name: :Like, dependent: :destroy

  # User-Comment association

  has_many :comments

  # Profile pic. Active storage

  has_one_attached :avatar, dependent: :destroy

  def full_name
    first_name + " " + last_name
  end

  def nationality_name
    ISO3166::Country.find_country_by_alpha2(nationality).name unless nationality
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.save(validate: false)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

    errors.add :password, 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def update_comments
    comments.update_all(body: "REMOVED")
  end

  def remove_friends
    Friendship.where(user: self).or(Friendship.where(friend: self)).destroy_all
  end

end
