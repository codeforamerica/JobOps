require 'places'

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
    search = @client.search(:lat => lat, :lng => long, :name => name)
    if !search.results.empty?
      geometry = search.results.first.geometry.first.last
      self.lat = geometry.lat
      self.long = geometry.lng
      self.save
    end
  end
end
