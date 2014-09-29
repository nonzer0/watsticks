class Interview < ActiveRecord::Base
  belongs_to :job

  default_scope -> { order('scheduled_on DESC')}
end
