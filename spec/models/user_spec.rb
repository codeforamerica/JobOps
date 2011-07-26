require 'spec_helper'

describe User do
  
  before do
    @user = Factory(:user)
  end
  
  describe "full_name" do
    it "should combine the first name and last name" do
      name = @user.full_name
      name.should == "GI Joe"
    end
  end
end
