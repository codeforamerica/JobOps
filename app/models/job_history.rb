class JobHistory < ActiveRecord::Base
  belongs_to :user
  has_one :user
  
  validates_presence_of :org_name
  validates_presence_of :title
  validates_presence_of :start_date
  
  def check_present(check_date)
    if check_date.nil?
      value = "Present"
    else
      value = check_date
    end
  end
end
