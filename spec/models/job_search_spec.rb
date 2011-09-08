require 'spec_helper'

describe JobSearch do
  before do
    @user = Factory(:user)
    @job_search = Factory(:job_search)
  end
  context 'relationships' do
    it 'belongs to user' do
      @job_search.respond_to?(:users).should be_true
    end
    it 'has many job searches user' do
      @job_search.respond_to?(:job_searches_users).should be_true
    end
    it 'has many job searches jobs' do
      @job_search.respond_to?(:job_searches_jobs).should be_true
    end
    it 'has many jobs' do
      @job_search.respond_to?(:jobs).should be_true
    end
    
  end
  
  context "special methods" do
    before do
      stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=Boston,%20MA&language=en&sensor=false").
               with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
               to_return(:status => 200, :body => fixture("google_map_location_boston.json"), :headers => {})
       stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
                with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
                to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})

    end
    
    it "detects moc code" do
      job_search1 = Factory(:job_search, :keyword => "12b")
      job_search2 = Factory(:job_search, :keyword => "011b")
      job_search3 = Factory(:job_search, :keyword => "Nurse")      
      
      job_search1.detect_moc?.should be_true
      job_search2.detect_moc?.should be_true      
      job_search3.detect_moc?.should be_false           
    end
    
    it "returns a newly created company when name is different" do
      Factory(:company, :location => "San Francisco, CA")    
      lambda {
        JobSearch.new.find_or_create_company("Code for America1", "San Francisco, CA")
      }.should change(Company, :count).by(1)
    end
    
    it "returns a newly created company when name and location is different" do    
      Factory(:company, :name => "Code for America")
      lambda {
        JobSearch.new.find_or_create_company("Code for America1", "Boston, MA")
      }.should change(Company, :count).by(1)      
    end
    
    it "returns a newly created company when location is different" do    
      Factory(:company, :location => "Boston, MA")
      lambda {
        JobSearch.new.find_or_create_company("Code for America1", "Toledo, OH")
      }.should change(Company, :count).by(1)      
    end
  
    it "returns a current company" do    
      company = Factory(:company, :name => "Code for America", :location => "San Francisco, CA")
      lambda {
        JobSearch.new.find_or_create_company("Code for America", "San Francisco, CA")
      }.should change(Company, :count).by(0)      
      return_company = JobSearch.new.find_or_create_company("Code for America", "San Francisco, CA")      
      company.should == return_company
    end
    
    it "returns a newly created location when name is different" do
      Factory(:location, :location => "Boston, MA")    
      lambda {
        JobSearch.new.find_or_create_location("San Francisco, CA")
      }.should change(Location, :count).by(1)
    end

    it "returns a current location" do    
      location = Factory(:location, :location => "San Francisco, CA")
      lambda {
        JobSearch.new.find_or_create_location("San Francisco, CA")
      }.should change(Location, :count).by(0)      
      return_location = JobSearch.new.find_or_create_location("San Francisco, CA")      
      location.should == return_location
    end    
    
    it 'proceses jobs' do
      @direct = SearchDirectEmployers.new.direct_client
      jobs = @direct.search({:moc => keyword})
      lambda {
        JobSearch.new.process_jobs(jobs)
      }.should change(Job, :count).by(10)
    end
    
    
  end
  
  
  
  
end
