require "spec_helper"

describe EducationsController do
  describe "routing" do

    it "routes to #index" do
      get("/educations").should route_to("educations#index")
    end

    it "routes to #new" do
      get("/educations/new").should route_to("educations#new")
    end

    it "routes to #show" do
      get("/educations/1").should route_to("educations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/educations/1/edit").should route_to("educations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/educations").should route_to("educations#create")
    end

    it "routes to #update" do
      put("/educations/1").should route_to("educations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/educations/1").should route_to("educations#destroy", :id => "1")
    end

  end
end
