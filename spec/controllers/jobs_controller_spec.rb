require 'spec_helper'

describe JobsController do
  before do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
      to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
    stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
       to_return(:status => 200, :body => fixture("futures_11b.json"))
    stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&moc=11B").
        to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
    stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&moc=11B&zc=San%20Francisco,%20CA").
        to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))

  end

  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template("jobs/index")
    end

    it "should render the results template page" do
      lambda {
        get :index, :search => {"job_searches_keyword_contains"=>"11B"}
        }.should change(JobSearch, :count).by(1)

        response.should render_template("jobs/index")
    end

    it "should render the results template page with results" do
      Factory(:job_search, :keyword => "11B", :location => "San Francisco, CA")
      get :index, :search => {"job_searches_keyword_contains"=>"11B","job_searches_location_contains" => "San Francisco, CA"}
      response.should render_template("jobs/index")
    end
  end

  describe "#dashboard" do
    before do
      @user = Factory(:user)
    end
    it "should render the dashboard template" do
      sign_in(@user)
      get :dashboard
      response.should render_template("jobs/dashboard")
    end

    it "should render jobs for a user not logged in" do
      get :dashboard
      response.should render_template("jobs/dashboard")
    end
  end


  describe "#show" do
    before do
      Factory(:job, :location => Factory(:location, :location => "San Francisco, CA"), :company => Factory(:company, :location => "San Francisco, CA") )
      @job = Job.find(:first)
    end

    it "should render the show template" do
      get :show, :id => @job
      response.should render_template("jobs/show")
    end

  end

  describe "#flag" do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @job = Factory(:job, :location => Factory(:location, :location => "San Francisco, CA"), :company => Factory(:company, :location => "San Francisco, CA") )
    end

    it "should flag a job" do
      lambda {
      get :flag, :id => @job
      }.should change(JobUser, :count).by(1)
    end

    it "should deflag a job" do
      @user.jobs << @job
      lambda {
      get :flag, :id => @job
      }.should change(JobUser, :count).by(-1)
    end

  end


end
