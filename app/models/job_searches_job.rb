class JobSearchesJob < ActiveRecord::Base
  belongs_to :job
  belongs_to :job_search
end
