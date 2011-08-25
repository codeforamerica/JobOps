require File.dirname(__FILE__) + '/../spec_helper'

describe AuthenticationsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "#create using Twitter"  do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it 'should login an existing user using Twitter' do
      @auth = Factory(:authentication)
      @user = Factory(:user)
      get :create, :provider => 'twitter'
      flash[:notice].should == "Signed in successfully."
      response.should redirect_to(root_url)
    end

    it "should create a new user using Twitter" do
      get :create, :provider => 'twitter'
      response.should redirect_to(new_user_registration_url)
    end
  end

  describe "#create new authentication using current_user" do
    login_user

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
    end

    it "should add a new authentication to an existing user using Twitter" do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      get :create, :provider => 'twitter'
      @auth = Authentication.last
      @auth.provider.should == 'twitter'
      flash[:notice].should == "Authentication successful."
      response.should redirect_to(authentications_url)
    end

    it "should add a new authentication to an existing user using Facebook" do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      get :create, :provider => 'facebook'
      @auth = Authentication.last
      @auth.provider.should == 'facebook'
      @auth.uid.should == '12345'
    end
  end

  describe "#create using Facebook"  do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it 'should login an existing user using Facebook' do
      @auth = Factory(:authentication, :provider => 'facebook')
      @user = Factory(:user)
      get :create, :provider => 'facebook'
      flash[:notice].should == "Signed in successfully."
      subject.current_user.should_not be_nil
    end

    it "should create a new user using Facebook" do
      stub_request(:get, "https://graph.facebook.com/me?access_token=abc123").
                to_return(:status => 200, :body => fixture("facebook_user.json"))
      get :create, :provider => 'facebook'
      @user = User.last
      @user.location.should == "San Francisco, California"
      @user.gender.should == "male"
      @user.job_histories.first.org_name.should == "Code for America"
      @user.job_histories.first.title.should == "Fellow"
    end

    it "should create a new user with no job history using Facebook" do
      stub_request(:get, "https://graph.facebook.com/me?access_token=abc123").
                to_return(:status => 200, :body => fixture("facebook_user_nowork.json"))
      get :create, :provider => 'facebook'
      @user = User.last
      @user.job_histories.empty?.should == true
    end

  end

  describe "auth_failure action should render authentication failure template" do
    it "should be successful" do
      get :auth_failure
      response.should render_template("authentications/auth_failure")
    end
  end

  describe "destroy action" do
    login_user

    before do
      @auth = Factory(:authentication)
      @auth_count = Authentication.all.size
      delete :destroy, :id => @auth.id
    end

    it "should destroy an authentication" do
      Authentication.all.size.should == @auth_count -1
      expect{@auth.reload}.to raise_error ActiveRecord::RecordNotFound
    end

    it "should redirect to  authentications_url" do
      @response.should redirect_to(authentications_url)
    end
  end

end
