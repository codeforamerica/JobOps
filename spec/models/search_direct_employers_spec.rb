require 'spec_helper'

describe SearchDirectEmployers do
  describe "#direct_client" do
    it "should return a new DirectEmployers client" do
      @direct = SearchDirectEmployers.new.direct_client
      @direct.should be_a DirectEmployers::Client
    end
  end

  describe "#direct_search_moc" do
    before do
      @direct = SearchDirectEmployers.new.direct_client
      stub_request(:get, "http://www.jobcentral.com/api.asp?key=&moc=11b").
        to_return(:status => 200, :body => fixture("direct_employers_11b.xml"))
    end

    it "should return a list of jobs related to MOC" do
      @results = @direct.search({:moc => "11b"})
      @results.api.jobs.job.last.company = "Code for America"
    end
  end

end
