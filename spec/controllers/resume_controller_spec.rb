require 'spec_helper'

describe ResumeController do
  
  login_user

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "edit action should render show template" do
    it "should be successful" do
      get :edit, :id => @user.id
      response.should render_template("resume/edit")
    end
  end
  
  describe '#update' do
    before do
      @user = Factory(:user)
      put :update, :id => @user.id, :user => { :resume => "I have updated my resume"
        }
    end

    it "should update the users resume" do
      @user.reload.first_name.should == "I have updated my resume"
    end
  end
end