require 'spec_helper'

describe "wars/index.html.erb" do
  before(:each) do
    assign(:wars, [
      stub_model(War,
        :war => "War"
      ),
      stub_model(War,
        :war => "War"
      )
    ])
  end

  it "renders a list of wars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "War".to_s, :count => 2
  end
end
