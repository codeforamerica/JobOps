class Education < ActiveRecord::Base
  belongs_to :user
  has_one :user
  
  validates_presence_of :school_name
  
  def valid_year(check_year)
    if not check_year.nil?
      check_year.year
    end
  end
end
