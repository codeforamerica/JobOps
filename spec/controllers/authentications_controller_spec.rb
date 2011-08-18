require File.dirname(__FILE__) + '/../spec_helper'

describe AuthenticationsController do
  login_user

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end


  describe "auth_failure action should render authentication failure template" do
    it "should be successful" do
      get :auth_failure
      response.should render_template("authentications/auth_failure")
    end
  end

  describe "destroy action" do
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
