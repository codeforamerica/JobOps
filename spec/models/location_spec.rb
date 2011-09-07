require 'spec_helper'

describe Location do
  before do
    @location = Factory(:location)
  end
  context "relationships" do
    it 'has many jobs' do
      @location.respond_to?(:jobs).should be_true      
    end
  end
end
