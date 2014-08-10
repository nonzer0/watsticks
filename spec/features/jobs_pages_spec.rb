require 'rails_helper'
require 'spec_helper'


describe "Jobs pages" do

  subject { page }

  describe "New Jobs page" do

    describe "for non-signed in user" do
      before { visit new_job_path }
      it { should have_content 'Sign in' }
    end
  end


  describe "show page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:job) { FactoryGirl.create(:job) }

    before do
      sign_in(user)
      visit job_path(job)
    end

    it { should have_content('Title') }
    it { should have_content('Company') }
    it { should have_content('Industry') }
    it { should have_content('Date Applied') }

    it { should have_content(job.title) }
    it { should have_content(job.company) }
    it { should have_content(job.industry) }
    it { should have_content(job.date_applied) }

    describe "index page" do
      let(:user) { FactoryGirl.create(:user_with_jobs) }
      let(:job1) { user.jobs.first }

      before do
        sign_in(user)
        visit jobs_path
      end

      it { should have_content("Here is a listing of the jobs you have applied for:") }
      it { should have_selector('th', text: "Title") }
      it { should have_selector('th', text: "Company") }
      it { should have_selector('th', text: "Industry") }
      it { should have_selector('th', text: "Date Applied") }
      it { should have_selector('th', text: "In Consideration?") }

       it { should have_content(job1.title) }
       it { should have_content(job1.title) }
       it { should have_content(job1.company) }
       it { should have_content(job1.industry) }
       it { should have_content(job1.date_applied.strftime('%a %d %b %Y')) }
       it { should have_content(job1.in_consideration) }
    end
  end
end
