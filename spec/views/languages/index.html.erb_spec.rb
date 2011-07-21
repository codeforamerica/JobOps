require 'spec_helper'

describe "languages/index.html.erb" do
  before(:each) do
    assign(:languages, [
      stub_model(Language,
        :language => "Language"
      ),
      stub_model(Language,
        :language => "Language"
      )
    ])
  end

  it "renders a list of languages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Language".to_s, :count => 2
  end
end
