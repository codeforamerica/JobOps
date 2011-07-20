require 'spec_helper'

describe "educations/index.html.erb" do
  before(:each) do
    assign(:educations, [
      stub_model(Education,
        :school_name => "School Name",
        :degree => "Degree",
        :study_field => "Study Field",
        :activities => "MyText",
        :notes => "MyText"
      ),
      stub_model(Education,
        :school_name => "School Name",
        :degree => "Degree",
        :study_field => "Study Field",
        :activities => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of educations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "School Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Degree".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Study Field".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
