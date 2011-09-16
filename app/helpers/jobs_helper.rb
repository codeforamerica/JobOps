module JobsHelper

  def save_search_tip
    "Saving job searches allows you to easily check important search terms each time you start a session on JobOps. Start saving searches and they will appear here. You can also update your MOC code in <a href='/users'>your profile</a>, and we will generate some job searches that fit your background."
  end

  def smart_filter_tip
    "Turning on Smart Filters helps you easily apply a set of filters to every job search you make, helping you to find the jobs you want, and eliminating results that don't apply to you. You can change these filters at any time. To turn off Smart Filters, change the Smart Filters setting to Off."
  end

  def save_search_blank
    "You don't have any saved searches. Saving job searches makes it easier to check important search terms each time you come to JobOps, so you don't have to search from scratch each time you come to JobOps. You can start saving searches that are relevant to you, or you can update your MOC code in <a href='/users'>your profile</a> to generate some recommended saved searches."
  end

  def flagged_jobs_blank
    "You don't have any flagged jobs. Flag jobs that interest you by clicking on the star next to job result title. Your flagged jobs will appear here; when you've flagged jobs, you can compare them."
  end

  def flagged_jobs_tip
    "Flagging jobs saves individual job listings so that you can more easily access and compare them later. Flagging noteworthy job listings helps you organize, compare, share, and apply for jobs."
  end

  def flag_tip
    "Clicking on the star next to the job listing flags it so you can easily find it later."
  end
  
  def jobs_not_found
    "Your search didn't return any jobs. Try searching for a more general term - for example 'engineer' instead of 'quality and operations engineer'. Also, updating your MOC code in <a href='/users'>your profile</a> will help us suggest job searches for you based on your background."
  end

  def search_params(param)
    case param
    when 'date_acquired_greater_than'
      "JOB POST AGE "
    when 'job_searches_keyword_contains'
      "KEYWORD "
    when 'job_searches_location_contains'
      "NEAR "
    when 'title_contains'
      "TITLE "
    when 'company_name_contains'
      "COMPANY "
    end
  end

end
