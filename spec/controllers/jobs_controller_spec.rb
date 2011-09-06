require 'spec_helper'

describe JobsController do

  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template("jobs/index")
    end
  end

  describe "#show" do
    before do
      Factory(:job)
      @job = Job.find(:first)
    end

    it "should render the show template" do
      get :show, :id => @job
      response.should render_template("jobs/show")
    end

  end


end
