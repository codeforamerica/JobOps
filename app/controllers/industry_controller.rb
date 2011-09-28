class IndustryController < ApplicationController
  def index
    @industry = Industry.all
  end

  def show
    @industry = IndustryLookup.where(:industry_id => params[:id]).order('title')
  end
end
