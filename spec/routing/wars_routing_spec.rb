require "spec_helper"

describe WarsController do
  describe "routing" do

    it "routes to #index" do
      get("/wars").should route_to("wars#index")
    end

    it "routes to #new" do
      get("/wars/new").should route_to("wars#new")
    end

    it "routes to #show" do
      get("/wars/1").should route_to("wars#show", :id => "1")
    end

    it "routes to #edit" do
      get("/wars/1/edit").should route_to("wars#edit", :id => "1")
    end

    it "routes to #create" do
      post("/wars").should route_to("wars#create")
    end

    it "routes to #update" do
      put("/wars/1").should route_to("wars#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/wars/1").should route_to("wars#destroy", :id => "1")
    end

  end
end
