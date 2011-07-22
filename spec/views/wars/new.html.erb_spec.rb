require 'spec_helper'

describe "wars/new.html.erb" do
  before(:each) do
    assign(:war, stub_model(War,
      :war => "MyString"
    ).as_new_record)
  end

  it "renders new war form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wars_path, :method => "post" do
      assert_select "input#war_war", :name => "war[war]"
    end
  end
end
