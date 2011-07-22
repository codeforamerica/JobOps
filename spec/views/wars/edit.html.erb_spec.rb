require 'spec_helper'

describe "wars/edit.html.erb" do
  before(:each) do
    @war = assign(:war, stub_model(War,
      :war => "MyString"
    ))
  end

  it "renders the edit war form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wars_path(@war), :method => "post" do
      assert_select "input#war_war", :name => "war[war]"
    end
  end
end
