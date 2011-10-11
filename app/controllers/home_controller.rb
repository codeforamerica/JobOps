class HomeController < ApplicationController
  def index

    @counter = 0
    if current_user
      job_search_ids = current_user.job_searches.map(&:id)

      if job_search_ids.blank?
        @search = Job.includes(:location,:job_searches_jobs).search(params[:search])
      else
        #Postgres does not like an empty IN ()
        @search = Job.includes(:location,:job_searches_jobs).where("job_searches_jobs.job_search_id IN (#{job_search_ids.join(", ")})").search(params[:search])
      end

      @jobs = @search.paginate(:page => params[:page], :per_page => 25)
      @jobs_json = @jobs.map { |job| {"id" => job.id, "location" => "#{job.company.location}", "latitude" => "#{job.company.lat}", "longitude" => "#{job.company.long}", "company" => job.company.name}}

      get_user_variables

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @jobs }
      end
    else
      # @jobs = Job.includes(:location,:job_searches_jobs).search(params[:search])
      redirect_to new_user_session_path
    end
  end

protected

  #Load the related careers based on Fututures API
  def careers(moc)
    Career.new.futures_pipeline.search(moc)
  end

  def get_user_variables
    if current_user
      @flagged_jobs = current_user.jobs
      @saved_searches = current_user.job_searches
      @careers = careers(current_user.moc) unless current_user.moc.blank?
    else
      @flagged_jobs = []
    end

    unless params[:search].nil?
      if(params[:search][:job_searches_keyword_contains] =~ /^\d/)
        @careers = careers(params[:search][:job_searches_keyword_contains])
      else
        @careers = []
      end
    end
  end
end
