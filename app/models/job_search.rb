class JobSearch < ActiveRecord::Base
  has_many :job_searches_users
  has_many :users, :through => :job_searches_users
  has_many :job_searches_jobs
  has_many :jobs, :through => :job_searches_jobs

  def search
    determine_search
  end

  def detect_moc?
    if keyword[0].to_i > 0
      true
    elsif keyword[0] == "0"
      true
    else
      false
    end
  end

  def determine_search
    if detect_moc?
      search_direct_moc
    else
      search_direct_keyword
      search_indeed
    end
  end

  def process_direct_employer_jobs(jobs)
    jobs.each do |job|
      new_job = Job.create(:date_acquired => job["dateacquired"] , :title => job["title"] ,:company => find_or_create_company(job["company"], job["location"]),:location => find_or_create_location(job["location"]), :url => job["url"])
      self.jobs << new_job
    end
  end

  def process_indeed_jobs(jobs)
    jobs.each do |job|
      new_job = Job.create(:date_acquired => job["date"] , :title => job["jobtitle"] ,:company => find_or_create_company(job["company"], job["location"]),:location => find_or_create_location(job["formattedLocation"]), :url => job["url"])
      self.jobs << new_job
    end
  end

  def search_direct_moc
    @direct = SearchDirectEmployers.new.direct_client
    jobs = @direct.search({:moc => keyword}).api.jobs.job
    process_direct_employer_jobs(jobs)
  end

  def search_direct_keyword
    @direct = SearchDirectEmployers.new.direct_client
    jobs = @direct.search({:kw => keyword}).api.jobs.job
    process_direct_employer_jobs(jobs)
  end

  def search_indeed
    @indeed = SearchIndeed.new.indeed_client
    jobs = @indeed.search({:q => keyword})
    process_indeed_jobs(jobs)
  end

  def find_or_create_company(name, location)
    c = Company.where(:name => name, :location => location)
    if c.blank?
      company = Company.create(:name => name, :location => location)
    else
      company = c.first
    end
    company
  end

  def find_or_create_location(location)
    l = Location.where(:location => location)
    if l.blank?
      location = Location.create(:location => location)
    else
      location = l.first
    end
    location
  end

end
