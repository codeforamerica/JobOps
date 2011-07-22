require 'spec_helper'

describe "Wars" do
  describe "GET /wars" do
    pending it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get wars_path
      response.status.should be(200)
    end
  end
end
