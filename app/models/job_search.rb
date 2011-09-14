class JobSearch < ActiveRecord::Base
  has_many :job_searches_users
  has_many :users, :through => :job_searches_users
  has_many :job_searches_jobs, :dependent => :destroy
  has_many :jobs, :through => :job_searches_jobs

  def search
    determine_search
  end

  def detect_moc?
    if keyword =~ /^\d/
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
      company = find_or_create_company(job["company"], job["location"])
      location = find_or_create_location(job["location"])
      find_job = Job.where(:title => job["title"], :company_id => company, :location_id => location, :job_source => "Direct_Employers")
      if !find_job.blank?
        self.jobs << find_job.first unless self.jobs.include?(find_job.first)
      else
        new_job = Job.create(:date_acquired => job["dateacquired"] , :title => job["title"] ,:company => company, :location => location, :url => job["url"], :job_source => "Direct_Employers")
        new_job.delay.process_checks        
        self.jobs << new_job unless !new_job.errors.blank?
      end
    end
  end

  def process_indeed_jobs(jobs)
    jobs.each do |job|
      company = find_or_create_company(job["company"], job["formattedLocation"])
      location = find_or_create_location(job["formattedLocation"])
      find_job = Job.where(:title => job["jobtitle"], :company_id => company, :location_id => location, :job_source => "Indeed")
      if !find_job.blank?
        self.jobs << find_job.first unless self.jobs.include?(find_job.first)
      else
        new_job = Job.create(:date_acquired => job["date"] , :title => job["jobtitle"],:company => company,:location => location, :url => job["url"], :job_source => "Indeed")
        new_job.delay.process_checks
        self.jobs << new_job unless !new_job.errors.blank?
      end
    end
  end

  def search_direct_moc
    @direct = SearchDirectEmployers.new.direct_client
    jobs = @direct.search({:moc => keyword}).api.jobs
    unless jobs.nil?
      process_direct_employer_jobs(jobs.job)
    end
  end

  def search_direct_keyword
    @direct = SearchDirectEmployers.new.direct_client
    jobs = @direct.search({:kw => keyword}).api.jobs
    unless jobs.nil?
      process_direct_employer_jobs(jobs.job)
    end
  end

  def search_indeed
    @indeed = SearchIndeed.new.indeed_client
    jobs = @indeed.search(:q => keyword)
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
