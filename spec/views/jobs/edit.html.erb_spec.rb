require 'spec_helper'

describe "jobs/edit.html.erb" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :company => "MyString",
      :location => "MyString",
      :title => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path(@job), :method => "post" do
      assert_select "input#job_company", :name => "job[company]"
      assert_select "input#job_location", :name => "job[location]"
      assert_select "input#job_title", :name => "job[title]"
      assert_select "input#job_url", :name => "job[url]"
    end
  end
end
