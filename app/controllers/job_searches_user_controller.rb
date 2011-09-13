class JobSearchesUserController < ApplicationController

  before_filter :authenticate_user!

  def index
    if current_user
      @saved_searches = current_user.job_searches
    end
  end

  def new
    search = JobSearch.where(:keyword => params[:keyword], :location => params[:location], :search_params => params[:search])
    current_user.job_searches.create(:keyword => params[:keyword], :location => params[:location], :search_params => params[:search]) unless !search.blank?

    message = {"message" => "Job search saved." }

    respond_to do |format|
      format.json { render :json => message }
    end
  end
end
