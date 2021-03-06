require 'spec_helper'

describe CareersController do

  describe "GET 'index'" do
    it "should list 50 careers at a time" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers.json?page=").
        to_return(:status => 200, :body => fixture("futures_careers.json"))
      get 'index'
      response.should be_success
    end

    it "should return paged results from a career" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers.json?page=7").
        to_return(:status => 200, :body => fixture("futures_careers.json"))
      get 'index', :page => 7
      response.should be_success
    end

    it "should return related careers for a MOC" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
        to_return(:status => 200, :body => fixture("futures_11b.json"))
      get 'index', :search => '11B'
      response.should be_success
    end

    it "should return careers based on a search" do
      get 'index', :search => 'computer'
      response.should be_success
    end

  end

  describe "GET 'index' for a logged in user" do
    before do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
        to_return(:status => 200, :body => fixture("futures_11b.json"))
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers.json").
        to_return(:status => 200, :body => fixture("futures_careers.json"))
    end

    it "should render the careers template" do
      @user = Factory(:user)
      sign_in(@user)
      get :index
      response.should render_template("careers/index")
    end

    it "should render the careers template with no MOC" do
      @user = Factory(:user, :moc => "")
      sign_in(@user)
      get :index
      response.should render_template("careers/index")
    end

    it "should render the careers template for a logged in user searching by MOC" do
      @user = Factory(:user, :moc => "")
      sign_in(@user)
      get :index, :search => "11B"
      response.should render_template("careers/index")
    end

    it "should render the careers template for a logged in user searching by career" do
      @user = Factory(:user, :moc => "")
      sign_in(@user)
      get :index, :search => "computer"
      response.should render_template("careers/index")
    end
  end

  describe "#show" do
    before do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/11-1021-00.json").
        to_return(:status => 200, :body => fixture("futures_11-1021-00.json"))
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=abc123&kw=General%20and%20Operations%20Managers").
        to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
      stub_request(:get, "http://api.indeed.com/ads/apisearch?co=us&filter=1&format=json&fromage=1&highlight=0&jt=&latlong=1&limit=30&publisher=xyz456&q=General%20and%20Operations%20Managers&radius=25&sort=relevance&st=&useragent=Mozilla/4.0%20Firefox&userip=77.88.216.22&v=2").
        to_return(:status => 200, :body => fixture("indeed_ruby.json"))
      stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
        to_return(:status => 200, :body => "", :headers => {})
      Factory(:job_search, :keyword => "General Operations Managers")
      Factory(:job, :location => Factory(:location, :location => "San Francisco, CA"), :company => Factory(:company, :location => "San Francisco, CA") )
    end

    it "should render the show template" do
      get 'show', :id => '11-1021-00'
      response.should render_template("careers/show")
    end
  end

  describe "#flag" do
    before do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
        to_return(:status => 200, :body => "", :headers => {})
      @user = Factory(:user)
      sign_in(@user)
      @career = Factory(:career)
    end

    it "should add a new career into the database" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/11-1021-00.json").
        to_return(:status => 200, :body => fixture("futures_career.json"))

      get :flag, :id => '11-1021-00'
      @last_career = Career.last
      @last_career.title.should == "General and Operations Managers"
    end

    it "should flag a career" do
      lambda {
      get :flag, :id => @career.api_safe_onet_code
      }.should change(CareerUser, :count).by(1)
    end

    it "should deflag a career" do
      @user.careers << @career
      lambda {
      get :flag, :id => @career.api_safe_onet_code
      }.should change(CareerUser, :count).by(-1)
    end

  end
end
