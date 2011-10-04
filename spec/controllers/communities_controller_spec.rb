require 'spec_helper'

describe CommunitiesController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "#twitter_user" do
    before do
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=11B").
        to_return(:status => 200, :body => "", :headers => {})
      @user = Factory(:user)
      sign_in(@user)
      @authentications = Factory(:authentication)
    end

    pending it "should follow the user" do

      stub_request(:post, "https://api.twitter.com/1/friendships/create.json").
         with(:body => {"screen_name"=>"sferik"}).
         to_return(:status => 200, :body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})


      get 'twitter_follow', :id => 'sferik'

      response.should be_success
    end
  end



end
