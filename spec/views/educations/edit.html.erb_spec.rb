require 'spec_helper'

describe "educations/edit.html.erb" do
  before(:each) do
    @education = assign(:education, stub_model(Education,
      :school_name => "MyString",
      :degree => "MyString",
      :study_field => "MyString",
      :activities => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit education form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => educations_path(@education), :method => "post" do
      assert_select "input#education_school_name", :name => "education[school_name]"
      assert_select "input#education_degree", :name => "education[degree]"
      assert_select "input#education_study_field", :name => "education[study_field]"
      assert_select "textarea#education_activities", :name => "education[activities]"
      assert_select "textarea#education_notes", :name => "education[notes]"
    end
  end
end
