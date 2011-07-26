require 'spec_helper'

describe DateHelper do
  
  describe "check_present" do
  
    it "should return date when date is present" do
      present = check_present(Date.today)
      present.should == Date.today
    end

    it "should return present when date is nil" do
      present = check_present(nil)
      present.should == "Present"
    end
  end
end