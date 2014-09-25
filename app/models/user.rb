class User < ActiveRecord::Base
  has_many :jobs, dependent: :destroy

	before_save { email.downcase }
  before_create { create_remember_token }
  validates :name, presence: true, length: { maximum: 48 }
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
  	                format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }
  validates_inclusion_of :employed, in: [true, false]

  has_secure_password
  validates :password, length: { minimum: 6 }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
