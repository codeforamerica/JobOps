class JobSearch < ActiveRecord::Base
  has_many :job_searches_users
  has_many :users, :through => :job_searches_user
end
