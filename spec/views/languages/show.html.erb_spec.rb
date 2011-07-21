require 'spec_helper'

describe "languages/show.html.erb" do
  before(:each) do
    @language = assign(:language, stub_model(Language,
      :language => "Language"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Language/)
  end
end
