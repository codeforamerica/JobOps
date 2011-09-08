class Company < ActiveRecord::Base
  has_many :jobs
  validates_presence_of :name
  validates_uniqueness_of :name
  
end
