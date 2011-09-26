class Job < ActiveRecord::Base
  belongs_to :location
  belongs_to :company
  has_many :job_searches_jobs
  has_many :job_searches, :through => :job_searches_jobs
  has_many :job_users
  has_many :users, :through => :job_users

  validates_presence_of :location, :company, :title, :date_acquired, :url, :job_source
  validates_uniqueness_of :title, :scope => [:company_id, :location_id, :url]

  # Attempts to follow a redirect url and update the job with the actual link
  def follow_and_update_redirect
    begin
      link = RedirectFollower('http://is.gd/bNZYZ')
    rescue
    end

    if link
      self.url = link unless link==self.url
      self.save
    end

  end

  def process_checks
    follow_and_update_redirect
  end
end
