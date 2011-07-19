require 'spec_helper'
require 'devise/test_helpers'

describe "devise/sessions/new.html.erb" do
  let(:user) do
    stub_model(User).as_new_record
  end

  before do
    assign(:user, user)
    # Devise provides resource and resource_name helpers and
    # mappings so stub them here.
    @view.stub(:resource).and_return(user)
    @view.stub(:resource_name).and_return('user')
    @view.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

  it "renders a form to sign the user in" do
    render
    rendered.should have_selector("form",
                                  :method => "post",
                                  :action => user_session_path
                                  ) do |form|
      form.should have_selector("input", :type => "submit")
    end
  end
end