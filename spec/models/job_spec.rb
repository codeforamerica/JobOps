require 'spec_helper'

describe Job do
  before do
    @job =Factory(:job)
  end
  
  context "validations" do
    
  end
  
  context "relationships" do
    it 'has many job searches' do
      @job.respond_to?(:job_search).should be_true
    end
  end
  
  context "job specific checks" do
    
    pending "it should look up/and or create a company"
    pending "it should look up/create location"
    pending "it should grab the url if its a redirect"
    pending "it should "
  end
end
