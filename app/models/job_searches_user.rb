class JobSearchesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :job_search
end
