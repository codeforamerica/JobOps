class WarsController < ApplicationController
  # GET /wars
  # GET /wars.json
  def index
    @wars = War.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wars }
    end
  end

  # GET /wars/1
  # GET /wars/1.json
  def show
    @war = War.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @war }
    end
  end

  # GET /wars/new
  # GET /wars/new.json
  def new
    @war = War.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @war }
    end
  end

  # GET /wars/1/edit
  def edit
    @war = War.find(params[:id])
  end

  # POST /wars
  # POST /wars.json
  def create
    @war = War.new(params[:war])

    respond_to do |format|
      if @war.save
        format.html { redirect_to @war, notice: 'War was successfully created.' }
        format.json { render json: @war, status: :created, location: @war }
      else
        format.html { render action: "new" }
        format.json { render json: @war.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wars/1
  # PUT /wars/1.json
  def update
    @war = War.find(params[:id])

    respond_to do |format|
      if @war.update_attributes(params[:war])
        format.html { redirect_to @war, notice: 'War was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @war.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wars/1
  # DELETE /wars/1.json
  def destroy
    @war = War.find(params[:id])
    @war.destroy

    respond_to do |format|
      format.html { redirect_to wars_url }
      format.json { head :ok }
    end
  end
end
