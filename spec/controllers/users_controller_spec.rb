require 'spec_helper'

describe UsersController do

  stub_user_moc_save
  login_user

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

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
      sign_in (@user)
      stub_request(:get, "http://militarydemo.pipelinenc.com/api/v1/careers/search.json?moc=22b").
        to_return(:status => 200, :body => "", :headers => {})
      put :update, :id => @user.id, :user => { :name => "Example",
        :military_status => "Active",
        :service_branch => "Army",
        :moc => "22b",
        :rank => "032",
        :disability => "None",
        :security_clearance => "Top Secret"
        }
    end

    it "should update a person" do
      @user.reload.name.should == "Example"
      @user.reload.military_status.should == "Active"
      @user.reload.service_branch.should == "Army"
      @user.reload.moc.should == "22b"
      @user.reload.rank.should == "032"
      @user.reload.disability.should == "None"
      @user.reload.security_clearance.should == "Top Secret"
    end
  end
end
