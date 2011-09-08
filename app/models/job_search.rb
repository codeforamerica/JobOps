class JobSearch < ActiveRecord::Base
  has_many :job_searches_users
  has_many :users, :through => :job_searches_users
  has_many :job_searches_jobs
  has_many :jobs, :through => :job_searches_jobs   
  
  def search
    
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
    end
  end
  
  def process_jobs(jobs)
    jobs.each do |job|
      Job.create(:date_acquired => job.data_acquired , :title => job.title ,:company => find_or_create_company(job.company),:location => find_or_create_location(job.location), :url => job.url)
    end
  end
  
  def search_direct_moc
    @direct = SearchDirectEmployers.new.direct_client
    jobs = @direct.search({:moc => keyword})
    process_jobs(jobs)
  end
  
  def search_direct_keyword
    @direct = SearchDirectEmployers.new.direct_client
    jobs = @direct.search({:keyword => keyword})
    process_jobs(jobs)
  end
  
  def search_indeed
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
