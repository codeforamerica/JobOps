require 'spec_helper'

describe "job_histories/show.html.erb" do
  before(:each) do
    @job_history = assign(:job_history, stub_model(JobHistory,
      :org_name => "Org Name",
      :title => "Title",
      :summary => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Org Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
