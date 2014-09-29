require 'rails_helper'

describe Interview  do
  let(:job) { FactoryGirl.create(:job) }
  before { @interview = job.interviews.build(scheduled_on: '2014-12-31') }
  subject { @interview }

  it { should respond_to(:scheduled_on) }

  it { should be_valid }
end
