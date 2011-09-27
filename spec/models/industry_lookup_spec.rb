require 'spec_helper'

describe IndustryLookup do
  context "relationships" do
    it 'it belongs to Industry' do
      @industry = IndustryLookup.new
      @industry.respond_to?(:industry).should be_true
    end
  end

end
