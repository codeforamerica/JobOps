class CareersController < ApplicationController
  before_filter :get_career

  def get_career
    @futures_careers = Career.new.futures_pipeline
  end

  def index
    @careers = @futures_careers.careers
  end

  def show
    @careers = @futures_careers.career(params[:id])

   respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @careers }
    end

  end

end
