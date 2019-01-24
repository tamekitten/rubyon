class Post < ApplicationRecord
  belongs_to :user
  validates :user, :body, presence: true
end
