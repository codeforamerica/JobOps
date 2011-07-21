require "spec_helper"

describe CertificationsController do
  describe "routing" do

    it "routes to #index" do
      get("/certifications").should route_to("certifications#index")
    end

    it "routes to #new" do
      get("/certifications/new").should route_to("certifications#new")
    end

    it "routes to #show" do
      get("/certifications/1").should route_to("certifications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/certifications/1/edit").should route_to("certifications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/certifications").should route_to("certifications#create")
    end

    it "routes to #update" do
      put("/certifications/1").should route_to("certifications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/certifications/1").should route_to("certifications#destroy", :id => "1")
    end

  end
end
