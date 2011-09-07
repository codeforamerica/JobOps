class Job < ActiveRecord::Base
  belongs_to :location
  belongs_to :company 
  
  validates_presence_of :location, :company, :title, :date_acquired, :url
  validates_uniqueness_of :title, :scope => [:company_id, :location_id, :url]
end
