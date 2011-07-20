class Education < ActiveRecord::Base
  belongs_to :user
  has_one :user
  
  validates_presence_of :school_name
end
