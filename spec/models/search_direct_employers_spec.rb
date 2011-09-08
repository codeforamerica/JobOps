require 'spec_helper'

describe SearchDirectEmployers do
  describe "#direct_client" do
    it "should return a new DirectEmployers client" do
      @direct = SearchDirectEmployers.new.direct_client
      @direct.should be_a DirectEmployers::Client
    end
  end
end
