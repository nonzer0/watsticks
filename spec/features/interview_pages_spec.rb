require 'rails_helper'

describe "Interview pages" do
	subject { page }

	describe "Index" do
    let(:user) { FactoryGirl.create(:user) }
    let(:job) { FactoryGirl.create(:job, company: "Weasels Inc.", user_id: user.id) }
    let(:interview) { Interview.create(scheduled_on: 1.day.from_now, job_id: job.id, user_id: user.id) }

		before do
      interview.save!
      sign_in(user)
			visit interviews_path
		end

		it { should have_title "INTERVIEWS" }
		it { should have_content "INTERVIEWS" }
    it { should have_content "Company" }
    it { should have_content "Main Contact" }
    it { should have_content "Date" }
    it { should have_content job.company }
    it { should have_content interview.scheduled_on }
	end

  describe "show page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:job) { FactoryGirl.create(:job, company: "Weasels Inc.", user_id: user.id) }
    let(:interview) { Interview.create(scheduled_on: 1.day.from_now, job_id: job.id, user_id: user.id) }

		before do
      interview.save!
      sign_in(user)
			visit interview_path(interview)
		end

    it { should have_content "Company" }
    it { should have_content "Main Contact" }
    it { should have_content "Date" }
    it { should have_content "Time" }

    it { should have_content job.company }
    it { should have_content interview.scheduled_on }

    it { should have_link "Delete interview" }
  end

  describe "new page" do

    describe "for non-signed in user" do
      before { visit new_interview_path }
      it { should have_content 'Sign in' }
    end
  end
end
