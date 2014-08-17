require 'spec_helper'

describe "Job" do
  let(:user) { FactoryGirl.create(:user) }
  before { @job = user.jobs.build(title: "Priest",
                                  company: "The Church",
                                  industry: "Afterlife",
                                  date_applied: Date.today,
                                  in_consideration: true) }

  subject { @job }

  it { should respond_to(:title) }
  it { should respond_to(:company) }
  it { should respond_to(:industry) }
  it { should respond_to(:date_applied) }
  it { should respond_to(:in_consideration) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should be_in_consideration }


  #TODO make this work
  #specify(@job) { should eq user }

  it { should be_valid }

  describe "when user_id not present" do
    before { @job.user_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id not present" do
    before { @job.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @job.title = " " }
    it { should_not be_valid }
  end

  describe "with blank company" do
    before { @job.company = " " }
    it { should_not be_valid }
  end

  describe "with blank industry" do
    before { @job.industry = " " }
    it { should_not be_valid }
  end

  describe "with blank data_applied" do
    before { @job.date_applied = " " }
    it { should_not be_valid }
  end

  describe "title too long" do
    before { @job.title = "a" * 49 }
    it { should_not be_valid }
  end

  describe "company too long" do
    before { @job.title = "a" * 49 }
    it { should_not be_valid }
  end

  describe "too long" do
    before { @job.title = "a" * 49 }
    it { should_not be_valid }
  end

  describe "contact associations" do
    let(:job) { FactoryGirl.create(:job_with_contacts) }

    before { @job.save }

    it "should destroy associated contacts" do
      contacts = @job.contacts.to_a
      @job.destroy
      expect(contacts).not_to be_empty
      contacts.each do |contact|
        expect(Contact.where(id: contact.id)).to be_empty
      end
    end
  end
end
