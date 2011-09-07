class JobSearch < ActiveRecord::Base
  has_many :job_searches_users
  has_many :users, :through => :job_searches_users
  has_many :job_searches_jobs
  has_many :jobs, :through => :job_searches_jobs   
end
