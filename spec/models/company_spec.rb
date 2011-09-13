require 'spec_helper'

describe Company do
  before do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=San%20Francisco,%20CA&language=en&sensor=false").
      to_return(:status => 200, :body => fixture("google_map_location_sfca.json"), :headers => {})
    @company = Factory(:company, :location => "San Francisco, CA", :name => "Code for America")    
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
      attr = Factory.attributes_for(:company, :name => @company.name, :location => @company.location)
      invalid_detail = Company.new(attr)
      invalid_detail.should have(1).error_on(:name)
    end

  end

  context 'Try to find the company in google places' do
    pending "update_location_if_found_in_google_places" do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/search/json?key=love&location=,&name=Code%20for%20America&radius=500&sensor=false").
               to_return(:status => 200, :body => fixture("places_google_cfa_sf.json"), :headers => {})      
      ENV['PLACES']='love'
      @company.update_location_if_found_in_google_places
    end
  end

end
