require 'rails_helper'

describe Interview  do
  let(:user) { FactoryGirl.create(:user_with_jobs) }
  #let(:job) { FactoryGirl.create(:job) }
  #before { @interview = job.interviews.build() }
  before { @interview = user.jobs.first.interviews.build(scheduled_on: '2014-12-31',
  														scheduled_time: '12:30 pm' ) }
  subject { @interview }

  it { should respond_to(:scheduled_on) }
  it { should respond_to(:scheduled_time) }
end
