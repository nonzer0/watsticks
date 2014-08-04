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

  		describe "after submit" do
  			before { click_button submit }

  			it { should have_title('Sign up') }
  			it { should have_content('error') }
  		end
  	end

  	describe "valid information" do
  		before do
  			fill_in "Name",         with: "Valid User"
        fill_in "Email",        with: "new@user.net"
        fill_in "Password",     with: "password"
        fill_in "Password confirmation", with: "password"
  		end

  		it "should create user" do
  			expect { click_button submit }.to change(User, :count).by 1
  		end

  		describe "after saving user" do
  			before { click_button submit }
  			let(:user) { User.find_by(email: "new@user.net") }

  			it { should have_content user.name }
  			it { should have_selector('div.alert.alert-success', text: "Account Created!")}
        it { should have_link('Sign out') }
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
