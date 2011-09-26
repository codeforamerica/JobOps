require 'spec_helper'

describe Company do
  before do
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
      to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
    @company = Factory(:company, :location => "San Francisco, CA", :name => "Code for America", :lat => 37, :long => -122)
  end
  context "relationships" do
    it 'has many jobs' do
      @company.respond_to?(:jobs).should be_true
    end
  end

  context "validations" do
    it "has to have a name" do
      @company.name = nil
      @company.should have(1).error_on(:name)
    end

    it "has to have a unique company" do
      attr = FactoryGirl.attributes_for(:company, :name => @company.name, :location => @company.location)
      invalid_detail = Company.new(attr)
      invalid_detail.should have(1).error_on(:name)
    end

  end

  describe 'Company#update_location_if_found_in_google_places' do
    before do
      ENV['PLACES'] = 'love'
    end

    it "should geocode the place if found in Google Places" do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/search/json?key=love&location=37.0,-122.0&name=Code%20for%20America&radius=500&sensor=false").
        to_return(:status => 200, :body => fixture("places_google_cfa_sf.json"), :headers => {:content_type => "application/json; charset=UTF-8"})
      @company.update_location_if_found_in_google_places
      a_request(:get, "https://maps.googleapis.com/maps/api/place/search/json?key=love&location=37.0,-122.0&name=Code%20for%20America&radius=500&sensor=false").
        should have_been_made
      @company.lat.should == 37.788299
      @company.long.should == -122.399983
    end

    it "should not geocode the place if not found in Google Places" do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/search/json?key=love&location=37.0,-122.0&name=Code%20for%20America&radius=500&sensor=false").
        to_return(:status => 200, :body => fixture("place_not_found.json"), :headers => {:content_type => "application/json; charset=UTF-8"})
      @company.update_location_if_found_in_google_places
      a_request(:get, "https://maps.googleapis.com/maps/api/place/search/json?key=love&location=37.0,-122.0&name=Code%20for%20America&radius=500&sensor=false").
        should have_been_made
      @company.lat.should == 37
      @company.long.should == -122
    end

  end
end
