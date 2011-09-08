require 'spec_helper'

describe JobsController do
  before do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
             with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
             to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
    
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


end
