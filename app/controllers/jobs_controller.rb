require 'will_paginate/array'
class JobsController < ApplicationController
  before_filter :authenticate_user!, :only => :flag
  # GET /jobs
  # GET /jobs.json
  def index
    @counter = 0
    if params[:q].nil? and params[:near].nil?
      if current_user
        job_search_ids = current_user.job_searches.map(&:id)
        @flagged_jobs = current_user.jobs
        @saved_searches = current_user.job_searches
        @jobs = Job.includes([:location,:job_searches_jobs]).where("job_searches_jobs.job_search_id IN (#{job_search_ids.join(", ")})").paginate(:page => params[:page], :per_page => 25)
        @jobs_json = @jobs.map { |job| {"id" => job.id, "location" => "#{job.location.location}", "latitude" => "#{job.location.lat}", "longitude" => "#{job.location.long}", "company" => job.company.name}}
      end
    else
      @flagged_jobs = []
      @saved_searched = [];

      if current_user
        job_search_ids = current_user.job_searches.map(&:id)
        @flagged_jobs = current_user.jobs
        @saved_searches = current_user.job_searches
      end

      job_search =  JobSearch.where(:keyword => params[:q], :location => params[:near])

      if job_search.blank?
        job_search = JobSearch.create(:keyword => params[:q], :location => params[:near])
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

      job_search.search
      @jobs = job_search.reload.jobs.paginate(:page => params[:page], :per_page => 25)

      unless current_user.moc.nil?
        @careers = Career.new.futures_pipeline.search(current_user.moc)
      end

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
