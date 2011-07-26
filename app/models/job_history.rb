class JobHistory < ActiveRecord::Base
  belongs_to :user
  has_one :user
  
  validates_presence_of :org_name
  validates_presence_of :title
  validates_presence_of :start_date
  

end
