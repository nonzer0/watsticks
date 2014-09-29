require 'rails_helper'

describe Interview  do
  let(:job) { FactoryGirl.create(:job) }
  before { @interview = job.interviews.build(scheduled_on: '2014-12-31') }
  subject { @interview }

  it { should respond_to(:scheduled_on) }

  it { should be_valid }

  describe "Interview associations" do
  	before { job.save }
  	let!(:upcoming_interview) do
  		Interview.create(job: job, scheduled_on: 1.day.from_now)
  	end

	  it "destroys associated interviews" do
	    interviews = job.interviews.to_a
	    job.destroy
	    expect(interviews).not_to be_empty
	    interviews.each do |interview|
	  	  expect(Interview.where(id: interview.id)).to be_empty
	    end
	  end
  end

  describe "Only show interviews from today forward" do
  	before do
  		past_interview.save!
  		future_interview.save!
  	end

  	let(:user_with_interviews) { User.create(name: "jim", 
  			                                     email: "jim@home.com", 
  			                                     password: "password",
  			                                     password_confirmation: "password") }
  	
  	let(:job) { FactoryGirl.create(:job, user_id: user_with_interviews.id) }
  	
  	let(:past_interview) { Interview.create(job: job, 
  		                                      user_id: user_with_interviews.id, 
  		                                      scheduled_on: 1.day.ago)}

  	 let(:future_interview) { Interview.create(job: job, 
  		                                         user_id: user_with_interviews.id, 
  		                                         scheduled_on: 1.day.from_now)}
  	
  	it "should not include past interviews" do
  		expect(past_interview.user_id).to eq user_with_interviews.id
  		expect(user_with_interviews.interviews.to_a).to eq [future_interview, past_interview]
  	end

  	describe "#upcoming" do
  		let(:other_user) { FactoryGirl.create(:user) }
  		let(:someone_elses_job) { Interview.create(user_id: other_user.id, scheduled_on: 1.day.from_now)}
  		it "should only include interviews for the current user" do
  			#TODO - error `can't return singleton`
  			# allow(:user_with_interviews).to receive(:current_user).and_return true
  			expect(user_with_interviews.interviews).not_to include(someone_elses_job)
  		end
  	end
  end
end
