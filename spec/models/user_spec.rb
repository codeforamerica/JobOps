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
      user_age = @age.age(Date.parse("1986-09-07"))
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
      @twitter = User.new.twitter_user(@user.id)
      @twitter.should be_a Twitter::Client
    end

  end

end
