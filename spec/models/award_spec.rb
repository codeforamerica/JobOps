require 'spec_helper'

describe Award do
  before do
    @award = Factory(:award)
  end
  context "relationships" do
    it 'belongs' do
      @award.respond_to?(:jobs).should be_true      
    end
  end
  
  context "validations" do
    it "has to have a name" do
      @award.name = nil
      @award.should have(1).error_on(:name)
    end
    
    it "has to have a unique award" do
      attr = Factory.attributes_for(:award, :name => @award.name)
      invalid_detail = award.new(attr)
      invalid_detail.should have(1).error_on(:name)      
    end
    
  end
  
  
end
