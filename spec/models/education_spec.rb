require 'spec_helper'

describe Education do

  describe "check if valid year" do
    year = Education.new.valid_year(Date.today)
    year.should == Date.today.year
  end

  describe "blank year should return nil" do
    year = Education.new.valid_year(nil)
    year.should == nil
  end
end
