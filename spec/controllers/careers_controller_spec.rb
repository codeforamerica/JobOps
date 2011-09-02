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
  end

  describe "#show" do
    it "should render the show template" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/11-1021-00.json").
        to_return(:status => 200, :body => fixture("futures_career.json"))
      get 'show', :id => '11-1021-00'
      response.should render_template("careers/show")
    end
  end

end
