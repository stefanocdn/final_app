require 'spec_helper'

describe Speaking do
  let(:user) { FactoryGirl.create(:user) }
  let(:language) { FactoryGirl.create(:language) }
  let(:speaking) { user.speakings.build(language_id: language.id) }

  subject { speaking }

  it { should be_valid }

  describe "accessible attributes" do
	it "should not allow access to user_id" do
		expect do
		Speaking.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
	end
  end

  describe "user methods" do
	  it { should respond_to(:user) }
	  it { should respond_to(:language) }
	  its(:user) { should == user }
	  its(:language) { should == language }
  end

  describe "when language id is not present" do
	  before { speaking.language_id = nil }
	  it { should_not be_valid }
  end

  describe "when user id is not present" do
	  before { speaking.user_id = nil }
	  it { should_not be_valid }
  end
end