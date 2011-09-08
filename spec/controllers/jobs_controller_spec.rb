require 'spec_helper'

describe JobsController do
  before do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
             with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
             to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
     stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
       to_return(:status => 200, :body => fixture("futures_11b.json"))
             
  end

  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template("jobs/index")
    end
  end

  describe "#show" do
    before do
      Factory(:job, :location => Factory(:location, :location => "San Francisco, CA") )
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
      @job = Factory(:job, :location => Factory(:location, :location => "San Francisco, CA") )
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
