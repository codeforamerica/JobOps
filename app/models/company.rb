class Company < ActiveRecord::Base
  has_many :jobs
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :location
  geocoded_by :location, :latitude => :lat, :longitude => :long
  after_validation do
    self.geocode unless !lat.nil?
  end 
  
  def update_location_if_found_in_google_places
    @client = Places::Client.new(:api_key => ENV['PLACES'])
    search = @client.search(:lat => self.lat, :lng => self.long, :name => self.name)
    geometry = search.results.first.geometry
    if geometry.first.last
      self.lat = geometry.first.last.lat
      self.long = geometry.first.last.lng
      self.save
    end
  end
  
  
end
