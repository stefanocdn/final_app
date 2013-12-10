require 'spec_helper'

describe Company do
  let(:company) { FactoryGirl.create(:company) }

	subject { company }

	it { should respond_to(:name) }
	it { should respond_to(:positions) }
	it { should respond_to(:users) }
	
	it { should be_valid }

end
