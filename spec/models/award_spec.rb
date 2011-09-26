require 'spec_helper'

describe Award do
  before do
    @award = Factory(:award)
  end
  context "relationships" do
    it 'belongs' do
      @award.respond_to?(:user).should be_true
    end
  end


end
