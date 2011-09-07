class Job < ActiveRecord::Base
  belongs_to :location
  belongs_to :company  
end
