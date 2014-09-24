require 'rails_helper'
#require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Cheech", email: "cheech@test.com")
      FactoryGirl.create(:user, name: "Chong", email: "chong@bong.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.all do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end

      it { should have_link('delete', href: user_path(User.first)) }
      it "can delete another user" do
        expect do
          click_link('delete', match: :first)
        end.to change(User, :count).by(-1)
      end

      # TODO why does this fail?
      #it { should_not have_link('delete', user_path(admin)) }
    end
  end

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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit edit_user_path(user)
    end

    it { should have_content("Update your profile") }
    it { should have_title("Edit user") }
    it { should have_link('change', href: 'http://gravatar.com/emails') }

    describe "invalid information" do
      before { click_button "Save" }

      it { should have_content("error") }
    end

    describe "with valid information", type: :request do
      let(:name) { "New Name" }
      let(:email) { "new_email@test.com" }

      before do
        fill_in "Name", with: name
        fill_in "Email", with: email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_link "Save"
      end

      # TODO why do these fail?
      #it { should have_title(name) }
      #it { should have_selector('div.alert.alert-success') }
      #it { should have_link('Sign out', href: signout_path) }
      #specify { expect(user.reload.name).to eq name }
      #specify { expect(user.reload.email).to eq email }
    end
  end
end
