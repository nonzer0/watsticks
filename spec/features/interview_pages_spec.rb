require 'rails_helper'

describe "Interview pages" do
	subject { page }

	describe "Index" do
		before do
			sign_in FactoryGirl.create(:user)
			job = FactoryGirl.create(:job)
			interview = job.interviews.build(scheduled_on: 1.day.from_now)
			visit interviews_path
		end

		it { should have_title "INTERVIEWS" }
		it { should have_content "Interviews" }
	end
end