require 'spec_helper'

describe "educations/show.html.erb" do
  before(:each) do
    @education = assign(:education, stub_model(Education,
      :school_name => "School Name",
      :degree => "Degree",
      :study_field => "Study Field",
      :activities => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/School Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Degree/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Study Field/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
