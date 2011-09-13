class JobSearchesUserController < ApplicationController
  def index
    if current_user
      @saved_searches = current_user.job_searches
    end
  end
end
