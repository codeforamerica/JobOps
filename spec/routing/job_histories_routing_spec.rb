require "spec_helper"

describe JobHistoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/job_histories").should route_to("job_histories#index")
    end

    it "routes to #new" do
      get("/job_histories/new").should route_to("job_histories#new")
    end

    it "routes to #show" do
      get("/job_histories/1").should route_to("job_histories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/job_histories/1/edit").should route_to("job_histories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/job_histories").should route_to("job_histories#create")
    end

    it "routes to #update" do
      put("/job_histories/1").should route_to("job_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/job_histories/1").should route_to("job_histories#destroy", :id => "1")
    end

  end
end
