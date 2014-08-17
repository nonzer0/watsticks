require 'rails_helper'

describe Contact do
  before { @contact = Contact.new(name: "Martha Washington",
                                  email: "martha@us.gov",
                                  phone_number: "555-1212",
                                  position: "recruiter") }
  subject { @contact }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:position) }

  it { should be_valid }

  describe "when name is too long" do
    before { @contact.name = "a" * 49 }
    it { should_not be_valid }
  end

  describe "when position is too long" do
    before { @contact.position = "a" * 49 }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @contact.name = " " }
    it { should_not be_valid }
  end

  describe "when position is not present" do
    before { @contact.position = " " }
    it { should_not be_valid }
  end
end
