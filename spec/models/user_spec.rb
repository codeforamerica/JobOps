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

  describe "age" do
    it "should return the users age" do
      @age = User.new
      user_age = @age.age(Date.parse("1986-09-07"))
      user_age.should == 24
    end
  end
end
