require 'spec_helper'

describe "awards/index.html.erb" do
  before(:each) do
    assign(:awards, [
      stub_model(Award,
        :award => "Award"
      ),
      stub_model(Award,
        :award => "Award"
      )
    ])
  end

  it "renders a list of awards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Award".to_s, :count => 2
  end
end
