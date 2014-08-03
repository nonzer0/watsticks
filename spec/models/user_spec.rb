require 'rails_helper'

describe User do
  before { @user = User.new(name: "Boris Karloff", email: "boris@kremlin.com",
                            password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

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
