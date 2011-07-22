require 'spec_helper'

describe "awards/new.html.erb" do
  before(:each) do
    assign(:award, stub_model(Award,
      :award => "MyString"
    ).as_new_record)
  end

  it "renders new award form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => awards_path, :method => "post" do
      assert_select "input#award_award", :name => "award[award]"
    end
  end
end
