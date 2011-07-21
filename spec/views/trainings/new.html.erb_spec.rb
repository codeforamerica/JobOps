require 'spec_helper'

describe "trainings/new.html.erb" do
  before(:each) do
    assign(:training, stub_model(Training,
      :training => "MyString"
    ).as_new_record)
  end

  it "renders new training form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => trainings_path, :method => "post" do
      assert_select "input#training_training", :name => "training[training]"
    end
  end
end
