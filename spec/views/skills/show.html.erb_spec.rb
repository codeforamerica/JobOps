require 'spec_helper'

describe "skills/show.html.erb" do
  before(:each) do
    @skill = assign(:skill, stub_model(Skill,
      :skill => "Skill",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Skill/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
