require 'spec_helper'

describe "jobs/show.html.erb" do
  before(:each) do
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
      to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})

    @job = Factory(:job, :location => Factory(:location,:location => "San Francisco, CA"), :company => Factory(:company, :location => "San Francisco, CA"))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Company/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Location/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(/Url/)
  end
end
