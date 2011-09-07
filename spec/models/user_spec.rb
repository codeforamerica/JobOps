require 'spec_helper'

describe User do

  before do
    @user = Factory(:user)
    @omniauth = {"user_info" => {"name" => "Jim Joe", "location" => "San Francisco"},
        "provider"=>"twitter","uid"=>"12345",
        "credentials"=>{"token"=>"abc123","secret"=>"xyz456"}}
  end

  describe "age" do
    it "should return the users age" do
      @age = User.new
      user_age = @age.age(Date.new(1986,9,7), Date.new(2011,1,1))
      user_age.should == 24
    end
  end

  describe "#build_athentications" do
    before do
      @test = User.new.apply_omniauth(@omniauth)
    end

    it "should add an authentication" do
      @test.provider.should == "twitter"
      @test.uid.should == "12345"
      @test.access_token.should == "abc123"
      @test.access_secret.should == "xyz456"
    end
  end

  describe "#twitter_client" do
    before do
      @auth = Factory(:authentication)
    end

    it "should return a new Twitter client" do
      @twitter = @user.twitter_user
      @twitter.should be_a Twitter::Client
    end

    it "should not return a new Twitter client" do
      @twitter = User.new.twitter_user
      @twitter.should be_nil
    end
  end

  describe "#facebook_client" do
    before do
      @auth = Factory(:authentication, :provider => "facebook")
    end

    it "should return a new Facebook client" do
      @facebook = @user.facebook_user
      @facebook.should be_a FbGraph::User
    end

    it "should not return a new Facebook client" do
      @facebook = User.new.facebook_user
      @facebook.should be_nil
    end
  end

  describe "#facebook_user" do
    before do
      @auth = Factory(:authentication, :provider => "facebook")
      stub_request(:get, "https://graph.facebook.com/me?access_token=abc123").
        to_return(:status => 200, :body => fixture("facebook_user.json"))
    end

    it "should fetch a facebook user" do
      @test = @user.facebook_user.fetch
      @test.name.should == "Ryan Resella"
    end
  end

  describe "#linked_in_user" do
    it "should not return an empty linked_in client" do
      @linked_in = @user.linked_in_user
      @linked_in.should be_nil
    end

    it "should return a new LinkedIn client" do
      @auth = Factory(:authentication, :provider => "linked_in")
      stub_request(:get, "https://api.linkedin.com/v1/people/~:(certifications,date-of-birth,educations,phone-numbers,positions,picture-url,skills,summary)").
        to_return(:status => 200, :body => fixture("linked_in_profile.xml"))
      @linked_in = @user.linked_in_user
      @linked_in.should be_a LinkedIn::Client
      @linked_in.profile.first_name.should == "Ryan"
      @linked_in.profile.last_name.should == "Resella"
    end
  end

  describe "#add_saved_search" do
    it "should add a saved search based on MOC code" do
      @user.add_saved_search
      @user.reload.job_searches.first.keyword.should == "10A"
    end
  end



end

