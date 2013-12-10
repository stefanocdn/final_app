require 'spec_helper'

describe Position do
  let(:user) { FactoryGirl.create(:user) }
  let(:company) { FactoryGirl.create(:company) }
  let(:position) { user.positions.build(city: "Paris",
       country: "France", company_id: company.id, start_date: 2001, end_date: 2004) }

  subject { position }

  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:city) }
  it { should respond_to(:country) }

  it { should be_valid }

  describe "accessible attributes" do
	it "should not allow access to user_id" do
		expect do
		Position.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
	end
  end

  describe "user methods" do
	  it { should respond_to(:user) }
	  it { should respond_to(:company) }
	  its(:user) { should == user }
	  its(:company) { should == company }
  end

  describe "when company id is not present" do
	  before { position.company_id = nil }
	  it { should_not be_valid }
  end

  describe "when user id is not present" do
	  before { position.user_id = nil }
	  it { should_not be_valid }
  end

  describe "with blank start date" do
    before { position.start_date = " " }
    it { should_not be_valid }
  end

  describe "with blank end date" do
    before { position.end_date = " " }
    it { should_not be_valid }
  end

  describe "with blank city" do
    before { position.city = " " }
    it { should_not be_valid }
  end

  describe "with blank country" do
    before { position.country = " " }
    it { should_not be_valid }
  end
end