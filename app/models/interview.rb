class Interview < ActiveRecord::Base
  belongs_to :job

  validates :scheduled_on, presence: true

  default_scope -> { order('scheduled_on DESC')}

  def interview_date
    self.scheduled_on.strftime('%B %d %Y')
  end

  def interview_time
    self.scheduled_on.strftime('%l:%M %p')
  end
end
