require 'spec_helper'

describe AccountController do
  login_user

  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template("account/index")
    end
  end

end
