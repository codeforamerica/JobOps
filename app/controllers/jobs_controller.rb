class JobsController < ApplicationController
  before_filter :authenticate_user!, :only => :flag
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @jobs }
    end
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

end
