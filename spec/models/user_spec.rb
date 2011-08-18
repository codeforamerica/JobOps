require 'spec_helper'

describe User do

  before do
    @user = Factory(:user)
    @omniauth = {"provider"=>"twitter","uid"=>"12345",
        "credentials"=>{"token"=>"abc123",
        "secret"=>"xyz456"}}
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
      @test = User.new.build_authentications(@omniauth)
    end

    it "should add an authentication" do
      @test.provider.should == "twitter"
      @test.uid.should == "12345"
      @test.access_token.should == "abc123"
      @test.access_secret.should == "xyz456"
    end
  end
end
