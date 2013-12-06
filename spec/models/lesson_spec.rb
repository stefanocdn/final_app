require 'spec_helper'

describe Lesson do

let(:user) { FactoryGirl.create(:user) }
  before { @lesson = user.lessons.build(title: "Lorem ipsum",
  	content: "Lorem ipsum", price: 50, 
      address: "279 Mott street New York") }

  subject { @lesson }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:price) }
  it { should respond_to(:address) }
  it { should respond_to(:longitude) }
  it { should respond_to(:latitude) }
  it { should respond_to(:categorizations) }
  it { should respond_to(:categories) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:tag_list) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Lesson.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @lesson.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @lesson.content = " " }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @lesson.title = " " }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @lesson.category_tokens = " " }
    it { should be_valid }
  end

  describe "with title that is too long" do
    before { @lesson.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank price" do
    before { @lesson.price = " " }
    it { should_not be_valid }
  end
end
