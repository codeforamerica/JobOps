require 'spec_helper'

describe JobSearchesUserController do

  stub_user_moc_save
  login_user

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "#create" do
    before do
      post :create, :search => Factory.attributes_for(:job_search)
    end
    pending it "should create a saved search" do

    end
  end

  describe "#destroy" do
    pending it "should delete a saved search" do
    end
  end

end
