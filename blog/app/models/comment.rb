class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post

  validates :user, :post, :body, presence: true
end
