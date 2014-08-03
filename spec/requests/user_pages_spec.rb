require 'rails_helper'
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
  end

  describe "signup" do

  	before { visit signup_path }

  	let(:submit) { "Create Account" }

  	describe "invalid info" do
  		it "should not create a user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end
  	end

  	describe "valid information" do
  		before do
  			fill_in "Name",         with: "Invalid User"
        fill_in "Email",        with: "bad@user.net"
        fill_in "Password",     with: "invalid"
        fill_in "Password confirmation", with: "invalid"
  		end

  		it "should create user" do
  			expect { click_button submit }.to change(User, :count).by 1
  		end 
  	end
  end

  describe "user profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
end