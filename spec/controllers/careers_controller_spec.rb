require 'spec_helper'

describe CareersController do

  describe "GET 'index'" do
    it "should be successful" do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers.json").
        to_return(:status => 200, :body => fixture("futures_careers.json"))
      get 'index'
      response.should be_success
    end
  end

end
