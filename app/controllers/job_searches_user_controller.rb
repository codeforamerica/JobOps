class JobSearchesUserController < ApplicationController

  before_filter :authenticate_user!

  def new
    keyword = params[:search][:job_searches_keyword_contains]
    location = params[:search][:job_searches_location_contains]
    search = JobSearch.where(:keyword => keyword, :location => location, :search_params => params[:search].to_yaml)
    if search.blank?
      search = JobSearch.create(:keyword => keyword, :location => location, :search_params => params[:search])
      current_user.job_searches << search
      message = {"message" => "Job search saved.", "newid" => search.id }
    else
      if current_user.job_searches.include?(search.first)
        message = {"error" => "Job search already saved." }
      else
      current_user.job_searches << search.first 
      message = {"message" => "Job search saved.", "newid" => search.first.id }
      end
    end

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
