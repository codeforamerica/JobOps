require 'spec_helper'

describe Location do
  before do
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
      to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})

    @location = Factory(:location, :location => "San Francisco, CA")
  end
  context "relationships" do
    it 'has many jobs' do
      @location.respond_to?(:jobs).should be_true
    end
  end

  context "validations" do
    it "has to have a location" do
      @location.location = nil
      @location.should have(1).error_on(:location)
    end

    it "has to have a unique location" do
      attr = FactoryGirl.attributes_for(:location, :location => "San Francisco, CA")
      invalid_detail = Location.new(attr)
      invalid_detail.should have(1).error_on(:location)
    end

  end


end
