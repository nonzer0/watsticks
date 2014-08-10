class Job < ActiveRecord::Base
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 48 }
  validates :company, presence: true, length: { maximum: 48 }
  validates :industry, presence: true
  validates :date_applied, presence: true
end
