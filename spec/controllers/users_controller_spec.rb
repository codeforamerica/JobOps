require 'spec_helper'

describe UsersController do
  
  login_user
  
  describe "show action should render show template" do
    it "should be successful" do
      get :show, :id => @user.id
      response.should render_template("users/profile/show")
    end
  end
end
