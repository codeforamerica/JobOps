require 'spec_helper'

describe "certifications/new.html.erb" do
  before(:each) do
    assign(:certification, stub_model(Certification,
      :name => "MyString",
      :institution => "MyString"
    ).as_new_record)
  end

  it "renders new certification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => certifications_path, :method => "post" do
      assert_select "input#certification_name", :name => "certification[name]"
      assert_select "input#certification_institution", :name => "certification[institution]"
    end
  end
end
