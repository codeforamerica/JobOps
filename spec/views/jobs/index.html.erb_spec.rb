require 'spec_helper'

describe "jobs/index.html.erb" do
  before(:each) do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
             with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
             to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
    location = Factory(:location, :location => "San Francisco, CA")
    @job = Factory(:job, :location => location)
    assign(:jobs, Job.all)
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @job.company.name, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @job.location.location, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @job.title, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @job.url, :count => 1
  end
end
