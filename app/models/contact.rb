class Contact < ActiveRecord::Base
  belongs_to :job

  validates :name, presence: true, length: { maximum: 48 }
  validates :position, presence: true, length: { maximum: 48 }
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
  	                format: { with: VALID_EMAIL }
end
