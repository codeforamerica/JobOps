require 'spec_helper'

describe "awards/edit.html.erb" do
  before(:each) do
    @award = assign(:award, stub_model(Award,
      :award => "MyString"
    ))
  end

  it "renders the edit award form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => awards_path(@award), :method => "post" do
      assert_select "input#award_award", :name => "award[award]"
    end
  end
end
