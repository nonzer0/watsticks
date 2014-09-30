class Interview < ActiveRecord::Base
  belongs_to :job

  validates :scheduled_on, presence: true

  default_scope -> { order('scheduled_on DESC')}
end
