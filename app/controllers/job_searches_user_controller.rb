class JobSearchesUserController < ApplicationController

  before_filter :authenticate_user!

  def index
    if current_user
      @saved_searches = current_user.job_searches
    end
  end

  def new
    keyword = params[:search][:job_searches_keyword_contains]
    location = params[:search][:job_searches_location_contains]
    search_params = params[:search]
    search = JobSearch.where(:keyword => keyword, :location => location, :search_params => search_params.to_s)
    search = JobSearch.create(:keyword => keyword, :location => location, :search_params => params[:search]) unless !search.blank?

    current_user.job_searches << search

    message = {"message" => "Job search saved.", "newid" => search.id }

    respond_to do |format|
      format.json { render :json => message }
    end
  end

  # DELETE /job_searches_user/1
  # DELETE /job_searcues_user/1.json
  def destroy
    @job_search = current_user.job_searches_user.find_by_job_search_id(params[:id])
    @job_search.destroy

    message = {"message" => "Job search removed."}

    respond_to do |format|
      format.json { render :json => message}
    end
  end
end
