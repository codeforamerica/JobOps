class JobHistory < ActiveRecord::Base
  belongs_to :user
  has_one :user

  validates_presence_of :org_name

end
