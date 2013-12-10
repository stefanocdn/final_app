require 'spec_helper'

describe Language do
  let(:language) { FactoryGirl.create(:language) }

	subject { language }

	it { should respond_to(:name) }
	
	it { should be_valid }
end
