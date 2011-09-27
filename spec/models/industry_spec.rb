require 'spec_helper'

describe Industry do
  before do
    @industry = Factory(:industry)
  end

  context "relationships" do
    it 'has many industrty lookups' do
      @industry.respond_to?(:industry_lookups).should be_true
    end
  end

end
