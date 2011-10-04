class CareersController < ApplicationController
  before_filter :authenticate_user!, :only => :flag
  before_filter :get_career

  def get_career
    @futures_careers = Career.new.futures_pipeline
  end

  def index
    @counter = 0
    @industry = Industry.all

    if current_user
      @flagged_careers = current_user.careers
      if params[:search].nil?
        if current_user.moc.blank?
          @careers = @futures_careers.careers
        else
          @careers = @futures_careers.search(current_user.moc)
        end
      else
        if(params[:search] =~ /^\d/)
          @careers = @futures_careers.search(params[:search])
        else
          @careers = IndustryLookup.where("title like ?", "%#{params[:search]}%")
        end
      end
    else
      @flagged_careers = []
      if params[:search]
        if(params[:search] =~ /^\d/)
          @careers = @futures_careers.search(params[:search])
        else
          @careers = IndustryLookup.where("title like ?", "%#{params[:search]}%")
        end
      else
        @careers = []
      end
    end
  end

  def show
    if current_user
      @flagged_careers = current_user.careers
      @flagged_jobs = current_user.jobs
    else
      @flagged_careers = []
      @flagged_jobs = []
    end

    @counter = 0
    @career = @futures_careers.career(params[:id])

    job_search = get_job_search(@career.title)
    @search = job_search.reload.jobs.includes(:company).search("job_searches_keyword_contains" => @career.title)

    @jobs = @search.order('date_acquired desc')
    @jobs = @jobs.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @careers }
    end
  end

  # Flag responds only to json requests
  def flag
    @career = Career.find_by_api_safe_onet_code(params[:id])

    if @career.blank?
      @onet_info = @futures_careers.career(params[:id])
      @career = Career.create(:title => @onet_info.title, :onet_code => @onet_info.onet_soc_code, :api_safe_onet_code => @onet_info.api_safe_onet_soc_code)
    end

    if current_user.careers.include?(@career)
      message = {"message" => "Flag for #{@career.title} removed." }
      current_user.career_users.where(:career_id => @career.id).first.delete
    else
      message = {"message" => "#{@career.title} flagged." }
      current_user.careers << @career
    end

    respond_to do |format|
      format.json {render :json => message }
    end

  end

protected
  def get_job_search(career)
    job_search =  JobSearch.where(:keyword => career)

    if job_search.blank?
      job_search = JobSearch.create(:keyword => career)
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
