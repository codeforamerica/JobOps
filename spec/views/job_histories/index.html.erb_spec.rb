require 'spec_helper'

describe "job_histories/index.html.erb" do
  before(:each) do
    assign(:job_histories, [
      stub_model(JobHistory,
        :org_name => "Org Name",
        :title => "Title",
        :summary => "MyText"
      ),
      stub_model(JobHistory,
        :org_name => "Org Name",
        :title => "Title",
        :summary => "MyText"
      )
    ])
  end

  it "renders a list of job_histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Org Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
