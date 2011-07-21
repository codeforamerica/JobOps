require "spec_helper"

describe TrainingsController do
  describe "routing" do

    it "routes to #index" do
      get("/trainings").should route_to("trainings#index")
    end

    it "routes to #new" do
      get("/trainings/new").should route_to("trainings#new")
    end

    it "routes to #show" do
      get("/trainings/1").should route_to("trainings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trainings/1/edit").should route_to("trainings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trainings").should route_to("trainings#create")
    end

    it "routes to #update" do
      put("/trainings/1").should route_to("trainings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trainings/1").should route_to("trainings#destroy", :id => "1")
    end

  end
end
