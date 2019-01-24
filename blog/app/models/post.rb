class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :marks
  has_many :commentators, through: :comments, source: :user
  has_many :estimators, through: :marks, source: :user

  validates :user, :body, presence: true
end
