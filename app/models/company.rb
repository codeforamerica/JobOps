class Company < ActiveRecord::Base
  has_many :jobs
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :location
  geocoded_by :address
  after_validation :geocode   
  
  def address
    self.location
  end
  
  def update_location_if_found_in_google_places
    @client = Places::Client.new(:api_key => ENV['PLACES'])
    search = @client.search(:lat => self.lat, :lng => self.long, :name => self.name)
    puts search.inspect
    geometry = search.results.first.geometry
    if geometry.first.last
      self.lat = geometry.first.last.lat
      self.long = geometry.first.last.lng
      self.save
    end
  end
  
  
end
