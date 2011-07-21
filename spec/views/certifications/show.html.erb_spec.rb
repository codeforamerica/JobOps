require 'spec_helper'

describe "certifications/show.html.erb" do
  before(:each) do
    @certification = assign(:certification, stub_model(Certification,
      :name => "Name",
      :institution => "Institution"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Institution/)
  end
end
