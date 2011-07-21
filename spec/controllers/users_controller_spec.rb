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
      put :update, :id => @user.id, :user => { :first_name => "Example",
        :military_status => "Active",
        :service_branch => "Army",
        :moc => "22b",
        :rank => "032",
        :disability => "None",
        :security_clearance => "Top Secret"
        }
    end

    it "should update a person" do
      @user.reload.first_name.should == "Example"
      @user.reload.military_status.should == "Active"
      @user.reload.service_branch.should == "Army"
      @user.reload.moc.should == "22b"
      @user.reload.rank.should == "032" 
      @user.reload.disability.should == "None" 
      @user.reload.security_clearance.should == "Top Secret"
    end
  end
end
