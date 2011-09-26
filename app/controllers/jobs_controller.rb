class JobsController < ApplicationController
  before_filter :authenticate_user!, :only => :flag
  # GET /jobs
  # GET /jobs.json
  def dashboard
    if current_user
      @counter = 0
      job_search_ids = current_user.job_searches.map(&:id)

      if job_search_ids.blank?
        @search = Job.includes(:location,:job_searches_jobs).search(params[:search])
      else
        #Postgres does not like an empty IN ()
        @search = Job.includes(:location,:job_searches_jobs).where("job_searches_jobs.job_search_id IN (#{job_search_ids.join(", ")})").search(params[:search])
      end

      @jobs = @search.paginate(:page => params[:page], :per_page => 25)
      @jobs_json = @jobs.map { |job| {"id" => job.id, "location" => "#{job.company.location}", "latitude" => "#{job.company.lat}", "longitude" => "#{job.company.long}", "company" => job.company.name}}
    else
      @search = Job.includes(:location,:job_searches_jobs).search(params[:search])
    end

    get_user_variables

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @jobs }
    end
  end

  def index
    @counter = 0
    if params[:search].nil?
      @jobs = []
      @search = Job.search(params[:search])
    else
      job_search = get_job_search
      @search = job_search.reload.jobs.includes(:company).search(params[:search])

      if params[:sortby].nil?
        @jobs = @search.order('date_acquired desc')
      else
        case params[:sortby]
        when 'date_desc'
          @jobs = @search.order('date_acquired desc')
        when 'date_asc'
          @jobs = @search.order('date_acquired asc')
        when 'company'
          @jobs = @search.order('companies.name asc')
        when 'title'
          @jobs = @search.order('title asc')
        end
      end

      @jobs = @jobs.paginate(:page => params[:page], :per_page => 25)
    end
    get_user_variables
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @job }
    end
  end

  # Flag responds only to json requests
  def flag
    @job = Job.find(params[:id])
    if current_user.jobs.include?(@job)
      message = {"message" => "Flag for #{@job.title} removed." }
      current_user.job_users.where(:job_id => @job.id).first.delete
    else
      message = {"message" => "#{@job.title} flagged." }
      current_user.jobs << @job
    end
    respond_to do |format|
      format.json { render :json => message }
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

  def get_job_search
    job_search =  JobSearch.where(:keyword => params[:search][:job_searches_keyword_contains], :location => params[:search][:job_searches_location_contains])

    if job_search.blank?
      job_search = JobSearch.create(:keyword => params[:search][:job_searches_keyword_contains], :location => params[:search][:job_searches_location_contains])
      job_search.search
    else
      if job_search.first.updated_at < 1.hour.ago
        job_search = job_search.first
      else
        job_search = job_search.first
        job_search.touch
        job_search.search
      end
    end

    job_search

  end

end
