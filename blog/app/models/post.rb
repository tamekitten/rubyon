class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_one :seo, as: :seoable, dependent: :destroy

  has_many :commentators, through: :comments, source: :user
  has_many :estimators, through: :marks, source: :user

  validates :user, :body, presence: true

  def self.all_by_moderators
    Post.where(user: User.where(moderator: true))
  end
end
