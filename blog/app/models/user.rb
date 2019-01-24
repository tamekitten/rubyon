class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :marks
  has_many :commented_posts, through: :comments, source: :post
  has_many :estimated_posts, through: :marks, source: :post

  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true
  validates :name, length: {minimum: 2, maximum: 20}
end
