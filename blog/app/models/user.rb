class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true
  validates :name, length: {minimum: 2, maximum: 20}
end
