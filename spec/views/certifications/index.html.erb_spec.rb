require 'spec_helper'

describe "certifications/index.html.erb" do
  before(:each) do
    assign(:certifications, [
      stub_model(Certification,
        :name => "Name",
        :institution => "Institution"
      ),
      stub_model(Certification,
        :name => "Name",
        :institution => "Institution"
      )
    ])
  end

  it "renders a list of certifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Institution".to_s, :count => 2
  end
end
