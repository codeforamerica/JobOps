require 'spec_helper'

describe Job do
  before do
    @job =Factory(:job)
  end
  
  context "validations" do
    it 'presence of title' do
    end

    it 'presence of location' do
    end

    it 'presence of company' do
    end
    
    it 'presence of company' do
    end
    
  end
  
  context "relationships" do
    pending 'has many job searches' do
      @job.respond_to?(:job_searches).should be_true
    end
    it 'belongs to location' do
      @job.respond_to?(:location).should be_true      
    end
    it 'belongs to company' do
      @job.respond_to?(:company).should be_true      
    end
  end
  
  context "job specific checks" do
    it "look ups or creates a company" do

    end
    pending "it should look up/create location"
    pending "it should grab the url if its a redirect"
    pending "it should "
  end
end
