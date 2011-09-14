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
        to_return(:status => 200, :body => fixture("google_map_location_boston.json"), :headers => {})
      stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
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
      Factory(:company, :name => "Code for America", :location => "San Francisco, CA")
      lambda {
        JobSearch.new.find_or_create_company("Code for America1", "Boston, MA")
      }.should change(Company, :count).by(1)
    end

    it "returns a newly created company when location is different" do
      Factory(:company, :location => "Boston, MA")
      lambda {
        JobSearch.new.find_or_create_company("Code for America1", "San Francisco, CA")
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

    it 'processes jobs for moc' do
      job_search = Factory(:job_search, :keyword => "11b")
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&moc=11b").to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
      @direct = SearchDirectEmployers.new.direct_client
      jobs = @direct.search({:moc => job_search.keyword}).api.jobs.job
      lambda {
        JobSearch.new.process_direct_employer_jobs(jobs)
      }.should change(Job, :count).by(9)
    end

    it 'processes jobs for keyword on direct employers' do
      job_search = Factory(:job_search, :keyword => "ruby")
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&kw=ruby").to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
      @direct = SearchDirectEmployers.new.direct_client
      jobs = @direct.search({:kw => job_search.keyword}).api.jobs.job
      lambda {
        JobSearch.new.process_direct_employer_jobs(jobs)
        Job.last.job_source.should == "Direct_Employers"
      }.should change(Job, :count).by(9)
    end

    it 'processes jobs for keyword on indeed' do
      job_search = Factory(:job_search, :keyword => "ruby")
      stub_request(:get, "http://api.indeed.com/ads/apisearch?co=us&filter=1&format=json&fromage=1&highlight=0&jt=&latlong=1&limit=30&publisher=xyz456&q=ruby&radius=25&sort=relevance&st=&useragent=Mozilla/4.0%20Firefox&userip=77.88.216.22&v=2").to_return(:status => 200, :body => fixture("indeed_ruby.json"))
      @indeed = SearchIndeed.new.indeed_client
      jobs = @indeed.search({:q => job_search.keyword})
      lambda {
        job_search.process_indeed_jobs(jobs)
        Job.last.job_source.should == "Indeed"
      }.should change(Job, :count).by(5)
    end

    it 'Indeed adds jobs to new job search if they already exist' do
      job_search = Factory(:job_search, :keyword => "ruby")
      job_search2 = Factory(:job_search, :keyword => "ruby")
      stub_request(:get, "http://api.indeed.com/ads/apisearch?co=us&filter=1&format=json&fromage=1&highlight=0&jt=&latlong=1&limit=30&publisher=xyz456&q=ruby&radius=25&sort=relevance&st=&useragent=Mozilla/4.0%20Firefox&userip=77.88.216.22&v=2").to_return(:status => 200, :body => fixture("indeed_ruby.json"))
      @indeed = SearchIndeed.new.indeed_client
      jobs = @indeed.search({:q => job_search.keyword})
      job_search.process_indeed_jobs(jobs)
      Job.all.size.should == 5
      JobSearchesJob.count.should == 5
      job_search2.process_indeed_jobs(jobs)
      Job.all.size.should == 5
      JobSearchesJob.count.should == 10
    end

    it 'DE search adds jobs to new job search if they already exist' do
      job_search = Factory(:job_search, :keyword => "ruby")
      job_search2 = Factory(:job_search, :keyword => "ruby")
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&kw=ruby").to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
      @direct = SearchDirectEmployers.new.direct_client
      jobs = @direct.search({:kw => job_search.keyword}).api.jobs.job
      job_search.process_direct_employer_jobs(jobs)
      Job.all.size.should == 9
      JobSearchesJob.count.should == 9
      job_search2.process_direct_employer_jobs(jobs)
      Job.all.size.should == 9
      JobSearchesJob.count.should == 18
    end

    it 'searches for moc using search method' do
      job_search = Factory(:job_search, :keyword => "11b")
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&moc=11b").to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
      lambda {
        job_search.search
      }.should change(Job, :count).by(9)
    end

    it 'searches for keyword using search method' do
      job_search = Factory(:job_search, :keyword => "ruby")
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&kw=ruby").to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
      stub_request(:get, "http://api.indeed.com/ads/apisearch?co=us&filter=1&format=json&fromage=1&highlight=0&jt=&latlong=1&limit=30&publisher=xyz456&q=ruby&radius=25&sort=relevance&st=&useragent=Mozilla/4.0%20Firefox&userip=77.88.216.22&v=2").to_return(:status => 200, :body => fixture("indeed_ruby.json"))
      lambda {
        job_search.search
      }.should change(Job, :count).by(14)
    end
  end
end
