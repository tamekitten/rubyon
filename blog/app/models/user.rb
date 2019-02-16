class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :oauth, dependent: :destroy
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

  def self.from_omniauth(auth, current_user)
    #$stderr.puts auth
    oauth = Oauth.find_by(uid: auth.uid, provider: auth.provider)

    if !oauth
      user = current_user if current_user
      user = User.find_by(email: auth.info.email) if !user
      user = User.new(name: auth.info.name, email: auth.info.email, password: Devise.friendly_token[0, 20]) if !user
      #user.skip_confirmation!

      oauth = Oauth.new(uid: auth.uid, provider: auth.provider, user: user, name: auth.info.name, email: auth.info.email, image_url: auth.info.image)
    end

    oauth
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise_facebook_data"] and session["devise_facebook_data"]["info"]
        user.email = data["info"]["email"] if user.email.blank?
        user.name = data["info"]["name"] if user.name.blank?
      end
    end
  end

private

  def log_before_destroy
    Rails.logger.info "####### We are going to destroy user #{name} #######"
  end

  def log_after_destroy
    Rails.logger.info "####### User #{name} successfully destroyed #######"
  end

end
