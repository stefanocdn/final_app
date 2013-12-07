class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :birthday,
   :password, :password_confirmation, :avatar, :summary, :gender

  has_secure_password
  mount_uploader :avatar, AvatarUploader

  # LESSONS
  has_many :lessons, dependent: :destroy

  # REVIEWS
  has_many :reviews, foreign_key: "reviewer_id", dependent: :destroy
  has_many :reviewed_users, through: :reviews, source: :reviewed
  has_many :reverse_reviews, foreign_key: "reviewed_id",
                class_name: "Review", dependent: :destroy
  has_many :reviewers, through: :reverse_reviews
  
  # CALLBACKS
  before_save { email.downcase! }
  before_save :create_remember_token

  # VALIDATIONS
  validates :first_name,  presence: true, length: { maximum: 30 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :unless => :password_not_required?
  validates :password_confirmation, presence: true, :unless => :password_not_required?
  after_validation { self.errors.messages.delete(:password_digest) }

  def to_s
    "#{first_name} #{last_name}"
  end

  def age
    Time.now.year - birthday.year if birthday?
  end

  private

  def create_remember_token
	self.remember_token = SecureRandom.urlsafe_base64
  end

  def password_not_required?
	persisted? && @password.blank? && @password_confirmation.blank?
  end
end
