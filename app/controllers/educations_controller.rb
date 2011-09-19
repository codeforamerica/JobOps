class EducationsController < ApplicationController

  before_filter :authenticate_user!

  # GET /educations
  # GET /educations.json
  def index
    @educations = Education.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @educations }
    end
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
    @education = Education.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @education }
    end
  end

  # GET /educations/new
  # GET /educations/new.json
  def new
    @education = Education.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @education }
    end
  end

  # GET /educations/1/edit
  def edit
    @education = Education.find(params[:id])
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = User.find_by_id(current_user.id).educations.new(params[:education])

    respond_to do |format|
      if @education.save
        format.html { redirect_to @education, :notice => 'Education was successfully created.' }
        format.json { render :json => @education, :status => :created, :location => @education }
      else
        format.html { render :action => "new" }
        format.json { render :json => @education.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /educations/1
  # PUT /educations/1.json
  def update
    @education = Education.find(params[:id])

    respond_to do |format|
      if @education.update_attributes(params[:education])
        format.html { redirect_to @education, :notice => 'Education was successfully updated.' }
        format.json { render :json => @education }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @education.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @education = Education.find(params[:id])
    @education.destroy

    respond_to do |format|
      format.html { redirect_to educations_url }
      format.json { render :json => @education }
    end
  end
end
