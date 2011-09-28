require 'spec_helper'

describe IndustryController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "#show" do
    before do
      @industry = Factory(:industry)
    end

    it "should return the show template" do
      get 'show', :id => 1
      response.should render_template('industry/show')
    end
  end

end
