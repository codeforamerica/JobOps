require 'spec_helper'

describe "skills/index.html.erb" do
  before(:each) do
    assign(:skills, [
      stub_model(Skill,
        :skill => "Skill",
        :user_id => 1
      ),
      stub_model(Skill,
        :skill => "Skill",
        :user_id => 1
      )
    ])
  end

  it "renders a list of skills" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Skill".to_s, :count => 2
  end
end
