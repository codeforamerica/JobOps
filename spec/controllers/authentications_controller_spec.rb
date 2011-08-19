require File.dirname(__FILE__) + '/../spec_helper'

describe AuthenticationsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "#create"  do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it 'should login an existing user' do
      @auth = Factory(:authentication)
      @user = Factory(:user)
      get :create, :provider => 'twitter'
      flash[:notice].should == "Signed in successfully."
      response.should redirect_to(root_url)
    end

    it "should create a new user" do
      get :create, :provider => 'twitter'
      response.should redirect_to(new_user_registration_url)
    end
  end

  describe "#create new authentication" do
    login_user

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      @user = Factory(:user)
    end

    it "should add a new authentication to an existing user" do
      get :create, :provider => 'twitter'
      flash[:notice].should == "Authentication successful."
      response.should redirect_to(authentications_url)
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
