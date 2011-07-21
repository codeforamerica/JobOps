require 'spec_helper'

describe "trainings/index.html.erb" do
  before(:each) do
    assign(:trainings, [
      stub_model(Training,
        :training => "Training"
      ),
      stub_model(Training,
        :training => "Training"
      )
    ])
  end

  it "renders a list of trainings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Training".to_s, :count => 2
  end
end
