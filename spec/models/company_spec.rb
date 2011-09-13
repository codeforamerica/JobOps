require 'spec_helper'

describe Company do
  before do
    @company = Factory(:company)
  end
  context "relationships" do
    it 'has many jobs' do
      @company.respond_to?(:jobs).should be_true
    end
  end

  context "validations" do
    it "has to have a name" do
      @company.name = nil
      @company.should have(1).error_on(:name)
    end

    it "has to have a unique company" do
      attr = FactoryGirl.attributes_for(:company, :name => @company.name, :location => @company.location)
      invalid_detail = Company.new(attr)
      invalid_detail.should have(1).error_on(:name)
    end

  end


end
