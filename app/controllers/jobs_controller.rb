class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index

    q = params[:q]
    near = params[:near]

    if q.nil? and near.nil?
      @jobs = Job.all
    else
      render "jobs/results"
    end

    #respond_to do |format|
     # format.html # index.html.erb
      #format.json { render :json => @jobs }
    #end
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

end
