require 'spec_helper'

describe User do

  before do
    @user = User.new(first_name: "Stephane", last_name: "Cedroni", email: "user@example.com",
    				birthday: Date.new(2001,2,3), password: "foobar", 
    				password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:birthday) }
  it { should respond_to(:avatar) }
  it { should respond_to(:gender) }
  it { should respond_to(:summary) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:age) }

  it { should respond_to(:lessons) }

  it { should respond_to(:reviews) }
  it { should respond_to(:reviewed_users) }
  it { should respond_to(:reverse_reviews) }
  it { should respond_to(:reviewers) }

  it { should respond_to(:scholarships) }
  it { should respond_to(:schools) }
  it { should respond_to(:speakings) }
  it { should respond_to(:languages) }
  it { should respond_to(:positions) }
  it { should respond_to(:companies) }

  it { should be_valid }
  it { should_not be_admin }

  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.first_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "lesson associations" do

    before { @user.save }
    let!(:older_lesson) do
      FactoryGirl.create(:lesson, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_lesson) do
      FactoryGirl.create(:lesson, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right lessons in the right order" do
      @user.lessons.recent.should == [newer_lesson, older_lesson]
    end

    it "should destroy associated lessons" do
      lessons = @user.lessons.dup
      @user.destroy
      lessons.should_not be_empty
      lessons.each do |lesson|
        Lesson.find_by_id(lesson.id).should be_nil
      end
    end
  end

  describe "review association" do
    let!(:reviewer) { FactoryGirl.create(:reviewer) }
    let!(:reviewed) { FactoryGirl.create(:reviewed) }
    # let!(:older_review) { reviewer.reviews.build(content: "Lorem ipsum",
    #  reviewed_id: reviewed.id, created_at: 1.day.ago) }
    # let!(:newer_review) { reviewer.reviews.build(content: "Lorem ipsum",
    #  reviewed_id: reviewed.id, created_at: 1.hour.ago) }

    let!(:older_review) do
      FactoryGirl.create(:review, reviewer: reviewer,
        reviewed: reviewed, created_at: 1.day.ago)
    end
    let!(:newer_review) do
      FactoryGirl.create(:review, reviewer: reviewer,
        reviewed: reviewed, created_at: 1.hour.ago)
    end

    it "should have the right reviews in the right order" do
      reviewed.reverse_reviews.should == [newer_review, older_review]
    end

    it "should have the right reverse reviews in the right order" do
      reviewer.reviews.should == [newer_review, older_review]
    end

    it "should destroy associated reviews" do
      reviews = reviewer.reviews.dup
      reverse_reviews = reviewed.reverse_reviews.dup
      reviewer.destroy
      reviews.should_not be_empty
      reviews.each do |review|
      Review.find_by_id(review.id).should be_nil
      end
      reverse_reviews.each do |review|
      Review.find_by_id(review.id).should be_nil
      end
    end

    it "should destroy associated reverse reviews" do
      reverse_reviews = reviewed.reverse_reviews.dup
      reviewed.destroy
      reverse_reviews.should_not be_empty
      reverse_reviews.each do |review|
      Review.find_by_id(review.id).should be_nil
      end
    end
  end

  describe "scholarships associations" do
    before { @user.save }
    let!(:school) { FactoryGirl.create(:school) }
    let!(:older_scholarship) do
      FactoryGirl.create(:scholarship, user: @user, school: school,
       start_date: "1999-02-03", end_date: "2001-02-03")
    end
    let!(:newer_scholarship) do
      FactoryGirl.create(:scholarship, user: @user, school: school,
       start_date: "2002-02-03", end_date: "2004-02-03")
    end
    it "should have the right scholarships in the right order" do
      @user.scholarships.should == [newer_scholarship, older_scholarship]
    end

    it "should destroy associated scholarships" do
      scholarships = @user.scholarships.dup
      @user.destroy
      scholarships.should_not be_empty
      scholarships.each do |sco|
        Scholarship.find_by_id(sco.id).should be_nil
      end
    end
  end
  describe "positions associations" do
    before { @user.save }
    let!(:company) { FactoryGirl.create(:company) }
    let!(:older_position) do
      FactoryGirl.create(:position, user: @user, company: company,
       start_date: "1999-02-03", end_date: "2001-02-03")
    end
    let!(:newer_position) do
      FactoryGirl.create(:position, user: @user, company: company,
       start_date: "2002-02-03", end_date: "2004-02-03")
    end

    it "should have the right positions in the right order" do
      @user.positions.should == [newer_position, older_position]
    end

    it "should destroy associated positions" do
      positions = @user.positions.dup
      @user.destroy
      positions.should_not be_empty
      positions.each do |pos|
        Position.find_by_id(pos.id).should be_nil
      end
    end
  end
  describe "speaking associations" do
    before { @user.save }
    let!(:speaking1) do
      FactoryGirl.create(:speaking, user: @user, language_name: "English")
    end
    let!(:speaking2) do
      FactoryGirl.create(:speaking, user: @user, language_name: "Italian")
    end

    it "should destroy associated speakings" do
      speakings = @user.speakings.dup
      @user.destroy
      speakings.should_not be_empty
      speakings.each do |spe|
        Speaking.find_by_id(spe.id).should be_nil
      end
    end
  end
end