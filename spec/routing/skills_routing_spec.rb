require "spec_helper"

describe SkillsController do
  describe "routing" do

    it "routes to #index" do
      get("/skills").should route_to("skills#index")
    end

    it "routes to #new" do
      get("/skills/new").should route_to("skills#new")
    end

    it "routes to #show" do
      get("/skills/1").should route_to("skills#show", :id => "1")
    end

    it "routes to #edit" do
      get("/skills/1/edit").should route_to("skills#edit", :id => "1")
    end

    it "routes to #create" do
      post("/skills").should route_to("skills#create")
    end

    it "routes to #update" do
      put("/skills/1").should route_to("skills#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/skills/1").should route_to("skills#destroy", :id => "1")
    end

  end
end
