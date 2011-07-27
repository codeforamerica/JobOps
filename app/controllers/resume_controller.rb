class ResumeController < ApplicationController
  def index

  end

  # GET /resumes/1/edit
  def edit
    @user = User.find_by_id(current_user.id)
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update

  end
end
