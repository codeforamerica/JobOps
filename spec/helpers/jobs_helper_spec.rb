require 'spec_helper'

describe JobsHelper do

  describe "#search_params" do
    context "it should return the formatted params" do
      it "should return JOB POST AGE" do
        result = search_params("date_acquired_greater_than")
        result.should == "JOB POST AGE "
      end

      it "should return KEYWORD" do
        result = search_params("job_searches_keyword_contains")
        result.should == "KEYWORD "
      end

      it "should return NEAR" do
        result = search_params("job_searches_location_contains")
        result.should  == "NEAR "
      end

      it "should return TITLE" do
        result = search_params("title_contains")
        result.should == "TITLE "
      end

      it "should return COMPANY " do
        result = search_params("company_name_contains")
        result.should == "COMPANY "
      end
    end
  end
end
