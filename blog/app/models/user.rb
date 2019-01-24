class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_one :seo, as: :seoable, dependent: :destroy

  has_many :commented_users, through: :comments, source: :commentable, source_type: :User
  has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
  has_many :estimated_posts, through: :marks, source: :post

  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true
  validates :name, length: {minimum: 2, maximum: 20}

  before_destroy :log_before_destroy
  after_destroy :log_after_destroy

private

  def log_before_destroy
    Rails.logger.info "####### We are going to destroy user #{name} #######"
  end

  def log_after_destroy
    Rails.logger.info "####### User #{name} successfully destroyed #######"
  end

end
