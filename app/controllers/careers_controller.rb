class CareersController < ApplicationController
  before_filter :get_career

  def get_career
    @futures_careers = Career.new.futures_pipeline
  end

  def index
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

  def show
    @careers = @futures_careers.career(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @careers }
    end
  end

end
