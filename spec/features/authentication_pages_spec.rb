require 'rails_helper'
require 'support/utilities'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    describe "invalid signin info" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting next page" do
        before { click_link "Home" }

        it { should_not have_selector("div.alert.alert-danger") }
      end
    end

    describe "valid signin info" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "after signout" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
    end
  end

  describe "authorization", type: :request do

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in(non_admin, no_capybara: true) }

      describe "submitting DELETE to Users#destroy" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "for users not signed in" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when user attempts to visit protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after sign in" do
          it "should render desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end

      describe "in Users controller" do

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end

        describe "attempting to visit edit page" do
          before { visit edit_user_path(user) }
          it { should have_title("Sign in") }
        end

        describe "submitting to update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "attempting to PATCH admin = true" do
          let(:user) { FactoryGirl.create(:user) }
          before { patch user_path(id: user.id, user: {admin: 1}) }

          specify { expect(user).not_to be_admin }
        end
      end
    end

    describe "as wrong user", type: :request do
      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user, email: 'other_user@test.com') }
      before { sign_in(user, no_capyara: true) }

      describe "submitting GET request" do
        before { get edit_user_path(other_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to signin_path }
      end

      describe "submitting PATCH request" do
        before { patch user_path(other_user) }
        specify { expect(response).to redirect_to signin_path }
      end
    end
  end
end
