require 'spec_helper'

describe JobHistory do
  
  describe "return date when date is present" do
    present = JobHistory.new.check_present(Date.today)
    present.should == Date.today
  end
  
  describe "return present when date is nil" do
    present = JobHistory.new.check_present(nil)
    present.should == "Present"
  end
  
  
  
end
