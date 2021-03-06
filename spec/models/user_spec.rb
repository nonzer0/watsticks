require 'rails_helper'

describe User do
  before { @user = User.new(name: "Boris Karloff",
                            email: "boris@kremlin.net",
                            password: "password",
                            password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:jobs) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin set to true" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "job associations" do
    before { @user.save }
    let!(:older_job) do
      FactoryGirl.create(:job, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_job) do
      FactoryGirl.create(:job, user: @user, created_at: 1.hour.ago)
    end

    it "should have correct jobs in correct order" do
      expect(@user.jobs.to_a).to eq [newer_job, older_job]
    end

    it "should destroy assciated jobs" do
      jobs = @user.jobs.to_a
      @user.destroy
      expect(jobs).not_to be_empty
      jobs.each do |job|
        expect(Job.where(id: job.id)).to be_empty
      end
    end
  end

  describe "remember token" do
    before { @user.save }
    it(:remember_token) { should_not be_blank }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "v" * 49 }
    it { should_not be_valid }
  end

  describe "when email is invalid format" do
    it "should be invalid" do
      addresses = %w[guy@poo,com someguy.org me.user@tree.
                     green@cheese_toys.com fart@fiz+buzz.biz rap@fee..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is valid format" do
    it "should be valid" do
      addresses = %w[moss@fear.com t-ER@ii.m.net flail.choice@nerf.ne d+u@fist.uk]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "email already exists in system" do
    before do
      user_with_existing_email = @user.dup
      user_with_existing_email.email = @user.email.upcase
      user_with_existing_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is blank" do
    before do
      @user = User.new(name: "Yule Brenner", email: "yule@b.com",
                       password: " ", password_confirmation: " ")
    end

    it { should_not be_valid }

    describe "when passwords do not match" do
      before { @user.password_confirmation = "something_else"}

      it { should_not be_valid }
    end
  end

  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end
end
