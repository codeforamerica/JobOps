require 'spec_helper'

describe "jobs/new.html.erb" do
  before(:each) do
    assign(:job, stub_model(Job,
      :company => "MyString",
      :location => "MyString",
      :title => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_company", :name => "job[company]"
      assert_select "input#job_location", :name => "job[location]"
      assert_select "input#job_title", :name => "job[title]"
      assert_select "input#job_url", :name => "job[url]"
    end
  end
end
