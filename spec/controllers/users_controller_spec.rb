require 'spec_helper'

describe UsersController do
  
  login_user
  
  describe "show action should render show template" do
    it "should be successful" do
      get :show, :id => @user.id
      response.should render_template("users/profile/show")
    end
  end
  
  describe "edit action should render show template" do
    it "should be successful" do
      get :edit, :id => @user.id
      response.should render_template("users/profile/edit")
    end
  end
  
  describe '#update' do
    before do
      @user = Factory(:user)
      put :update, :id => @user.id, :user => { :first_name => "Example" }
      @response = response
    end

    it "should update a person" do
      @user.reload.first_name.should == "Example"
    end
  end
end
