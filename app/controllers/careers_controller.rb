class CareersController < ApplicationController
  def index
    @careers = Career.new.futures_pipeline.careers
  end

  def show
  end

end
