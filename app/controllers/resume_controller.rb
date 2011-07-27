class ResumeController < ApplicationController
  def index
    @user = User.find_by_id(current_user.id)
  end

  # GET /resumes/1/edit
  def edit
    @user = User.find_by_id(current_user.id)
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @user = User.find_by_id(current_user.id)
    
    respond_to do |format|
         if @user.update_attributes(params[:user])
           format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
           format.xml  { head :ok }
         else
           format.html { render :action => "edit" }
           format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
         end
    end
  end
end
