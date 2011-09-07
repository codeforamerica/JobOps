class Location < ActiveRecord::Base
  has_many :jobs
  validates_presence_of :location
  geocoded_by :location
  after_validation :geocode 
  
end
