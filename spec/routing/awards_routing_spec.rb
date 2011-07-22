require "spec_helper"

describe AwardsController do
  describe "routing" do

    it "routes to #index" do
      get("/awards").should route_to("awards#index")
    end

    it "routes to #new" do
      get("/awards/new").should route_to("awards#new")
    end

    it "routes to #show" do
      get("/awards/1").should route_to("awards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/awards/1/edit").should route_to("awards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/awards").should route_to("awards#create")
    end

    it "routes to #update" do
      put("/awards/1").should route_to("awards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/awards/1").should route_to("awards#destroy", :id => "1")
    end

  end
end
