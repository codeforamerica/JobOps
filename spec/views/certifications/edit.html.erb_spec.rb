require 'spec_helper'

describe "certifications/edit.html.erb" do
  before(:each) do
    @certification = assign(:certification, stub_model(Certification,
      :name => "MyString",
      :institution => "MyString"
    ))
  end

  it "renders the edit certification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => certifications_path(@certification), :method => "post" do
      assert_select "input#certification_name", :name => "certification[name]"
      assert_select "input#certification_institution", :name => "certification[institution]"
    end
  end
end
