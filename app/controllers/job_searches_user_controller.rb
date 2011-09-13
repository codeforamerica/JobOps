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

    current_user.job_searches << search

    message = {"message" => "Job search saved." }

    respond_to do |format|
      format.json { render :json => message }
    end
  end

  # DELETE /job_searches_user/1
  # DELETE /job_searcues_user/1.json
  def destroy
    @job_search = current_user.job_searches_user.find(params[:id])
    @job_search.destroy

    message = {"message" => "Job search removed."}

    respond_to do |format|
      format.json { render :json => message}
    end
  end
end
