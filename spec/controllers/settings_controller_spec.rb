require 'spec_helper'

describe SettingsController do
  login_user

  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template("settings/index")
      response.should be_success
    end
  end
end
