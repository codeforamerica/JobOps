require 'spec_helper'

describe SearchIndeed do
  describe "#indeed_client" do
    it "should return an Indeed class" do
      @indeed = SearchIndeed.new.indeed_client
      @indeed.should be_a Indeed
    end
  end
end
