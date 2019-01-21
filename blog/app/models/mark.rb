class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, :post, :mark, presence: true
  validates :mark, numericality: {greater_than: 0, less_than_or_equal_to: 5}
end
