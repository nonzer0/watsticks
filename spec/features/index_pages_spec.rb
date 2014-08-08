require 'rails_helper'

RSpec.describe "Index pages", :type => :request do
  describe "index_pages" do
    it "should have the content 'Watsticks'" do
      visit '/'
      expect(page).to have_content('Watsticks')
    end
  end
end
