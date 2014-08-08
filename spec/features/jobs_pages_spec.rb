require 'rails_helper'
require 'spec_helper'


describe "Jobs pages" do

  subject { page }

  describe "New Jobs page" do
    before { visit new_job_path }

    it { should have_content('Title') }
    it { should have_content('Company') }
    it { should have_content('Industry') }
    it { should have_content('Date Applied') }
  end


  describe "show page" do
    let(:job) { FactoryGirl.create(:job) }
    before { visit job_path(job) }

    it { should have_content(job.title) }
    it { should have_content(job.company) }
    it { should have_content(job.industry) }
    it { should have_content(job.date_applied) }
  end

  describe "index page" do
    let(:job) { FactoryGirl.create(:job) }
    before { visit jobs_path }

    it { should have_content("Here is a listing of the jobs you have applied for:") }
    it { should have_selector('th', text: "Title") }
    it { should have_selector('th', text: "Company") }
    it { should have_selector('th', text: "Industry") }
    it { should have_selector('th', text: "Date Applied") }
    it { should have_selector('th', text: "In Consideration?") }

    # it { should have_content(job.title) }
    # it { should have_content(job.company) }
    # it { should have_content(job.industry) }
    # it { should have_content(job.date_applied) }
    # it { should have_content(job.in_consideration) }
  end
end
