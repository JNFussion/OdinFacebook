class Post < ApplicationRecord
  
  validates :author, presence: true
  validates :photo,
            content_type: [:gif, :png, :jpg, :jpeg],
            size: { less_than: 2.megabytes , message: 'must be less than 2MB in size' }
  validates :photo, presence: true unless :url_photo
  validates :url_photo, presence: true unless :photo
  validates :content, presence: true unless :url_photo || :photo
  validate :not_empty_post
  belongs_to :author, class_name: :User, foreign_key: :user_id

  has_many :votes, class_name: :Like, dependent: :destroy
  has_many :likes, -> { liked }, class_name: :Like
  has_many :dislikes, -> { disliked }, class_name: :Like

  has_many :comments, as: :commentable, dependent: :destroy

  has_one_attached :photo, dependent: :destroy


  def not_empty_post
    errors.add(:base, "Post can't be empty") unless url_photo.present? ^ photo.attached? || content.present?
  end
end
