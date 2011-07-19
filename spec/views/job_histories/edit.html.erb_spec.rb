require 'spec_helper'

describe "job_histories/edit.html.erb" do
  before(:each) do
    @job_history = assign(:job_history, stub_model(JobHistory,
      :org_name => "MyString",
      :title => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders the edit job_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => job_histories_path(@job_history), :method => "post" do
      assert_select "input#job_history_org_name", :name => "job_history[org_name]"
      assert_select "input#job_history_title", :name => "job_history[title]"
      assert_select "textarea#job_history_summary", :name => "job_history[summary]"
    end
  end
end
