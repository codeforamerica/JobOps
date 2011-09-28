class CareersController < ApplicationController
  before_filter :authenticate_user!, :only => :flag
  before_filter :get_career

  def get_career
    @futures_careers = Career.new.futures_pipeline
  end

  def index

    @industry = Industry.all

    if current_user
      if params[:moc].nil?
        if current_user.moc.blank?
          @careers = @futures_careers.careers
        else
          @careers = @futures_careers.search(current_user.moc)
        end
      else
        @careers = @futures_careers.search(params[:moc])
      end
    else
      if params[:moc]
        @careers = @futures_careers.search(params[:moc])
      else
        @careers = @futures_careers.careers({:page => params[:page]})
        @next_page = params[:page].to_i + 1
        @prev_page = params[:page].to_i - 1

        if @next_page == 1
          @next_page = 2
        end

        if @prev_page == -1
          @prev_page = 1
        end
      end
    end
  end

  def show
    @careers = @futures_careers.career(params[:id])

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

end
