require 'spec_helper'

describe JobSearchesUserController do

  stub_user_moc_save
  login_user

  describe "#create" do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @search = {"date_acquired_greater_than"=>"",
        "job_searches_keyword_contains"=>"ruby",
        "job_searches_location_contains"=>"San Francisco, CA",
        "title_contains"=>"", "company_name_contains"=>""}
    end
    it "should create a saved search for the user" do
      lambda {
        get :new, :search => @search
      }.should change(JobSearchesUser, :count).by(1)
    end
  end

  describe "#destroy" do
   it "should delete a saved search" do
      lambda {
        get :destroy, :id => 1
      }.should change(JobSearchesUser, :count).by(-1)
    end
  end
end
