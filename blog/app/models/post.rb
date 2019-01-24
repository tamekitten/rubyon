class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :marks, dependent: :destroy

  has_many :commentators, through: :comments, source: :user
  has_many :estimators, through: :marks, source: :user

  validates :user, :body, presence: true
end
