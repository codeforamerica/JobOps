class CertificationsController < ApplicationController

  before_filter :authenticate_user!

  # GET /certifications
  # GET /certifications.json
  def index
    @certifications = Certification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @certifications }
    end
  end

  # GET /certifications/1
  # GET /certifications/1.json
  def show
    @certification = Certification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @certification }
    end
  end

  # GET /certifications/new
  # GET /certifications/new.json
  def new
    @certification = Certification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @certification }
    end
  end

  # GET /certifications/1/edit
  def edit
    @certification = Certification.find(params[:id])
  end

  # POST /certifications
  # POST /certifications.json
  def create
    @certification = User.find(current_user.id).certifications.new(params[:certification])

    respond_to do |format|
      if @certification.save
        format.html { redirect_to @certification, :notice => 'Certification was successfully created.' }
        format.json { render :json => @certification, :status => :created, :location => @certification }
      else
        format.html { render :action => "new" }
        format.json { render :json => @certification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /certifications/1
  # PUT /certifications/1.json
  def update
    @certification = Certification.find(params[:id])

    respond_to do |format|
      if @certification.update_attributes(params[:certification])
        format.html { redirect_to @certification, :notice => 'Certification was successfully updated.' }
        format.json { render :json => @certification }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @certification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /certifications/1
  # DELETE /certifications/1.json
  def destroy
    @certification = Certification.find(params[:id])
    @certification.destroy

    respond_to do |format|
      format.html { redirect_to certifications_url }
      format.json { render :json => @certification }
    end
  end
end
