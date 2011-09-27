class IndustryController < ApplicationController
  def index
    @industry = Industry.all
  end

  def show
    @industry = Industry.find(params[:id])
  end
end
