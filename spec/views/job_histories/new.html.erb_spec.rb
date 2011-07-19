require 'spec_helper'

describe "job_histories/new.html.erb" do
  before(:each) do
    assign(:job_history, stub_model(JobHistory,
      :org_name => "MyString",
      :title => "MyString",
      :summary => "MyText"
    ).as_new_record)
  end

  it "renders new job_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => job_histories_path, :method => "post" do
      assert_select "input#job_history_org_name", :name => "job_history[org_name]"
      assert_select "input#job_history_title", :name => "job_history[title]"
      assert_select "textarea#job_history_summary", :name => "job_history[summary]"
    end
  end
end
