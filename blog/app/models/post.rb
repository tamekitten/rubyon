class Post < ApplicationRecord
  belongs_to :user, counter_cache: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_one :seo, as: :seoable, dependent: :destroy

  has_many :commentators, through: :comments, source: :user
  has_many :estimators, through: :marks, source: :user

  validates :user, :body, presence: true

  scope :all_by_moderators, -> { joins(:user).where(users: {moderator: true}) }
end
