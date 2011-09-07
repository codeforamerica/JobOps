require 'spec_helper'

describe Job do
  before do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
     with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
     to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
    @company = Factory(:company)
    @location = Factory(:location, :location => "San Francisco, CA")
    @job=Factory(:job, :location => @location)
  end
  
  context "validations" do
    it 'presence of title' do
      @job.title = nil
      @job.should have(1).error_on(:title)      
    end

    it 'presence of location' do
      @job.location = nil
      @job.should have(1).error_on(:location)      
      
    end

    it 'presence of company' do
      @job.company = nil
      @job.should have(1).error_on(:company)      
      
    end
    
    it 'presence of url' do
      @job.url = nil
      @job.should have(1).error_on(:url)      
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
