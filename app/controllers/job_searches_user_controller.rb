class JobSearchesUserController < ApplicationController

  before_filter :authenticate_user!

  def index
    if current_user
      @saved_searches = current_user.job_searches
    end
  end
end
