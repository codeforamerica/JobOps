class IndustryController < ApplicationController
  def index
    @industry = Industry.all
  end

  def show
    @careers = IndustryLookup.where(:industry_id => params[:id]).order('title')
  end
end
