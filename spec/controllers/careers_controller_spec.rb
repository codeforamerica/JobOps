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
      get 'index', :moc => '11B'
      response.should be_success
    end
  end

  describe "GET 'index' for a logged in user" do
    before do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
        to_return(:status => 200, :body => fixture("futures_11b.json"))
      @user = Factory(:user)
    end

    it "should render the careers template" do
      sign_in(@user)
      get :index
      response.should render_template("careers/index")
    end
  end

  describe "#show" do
    it "should render the show template" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/11-1021-00.json").
        to_return(:status => 200, :body => fixture("futures_career.json"))
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
