class CommunitiesController < ApplicationController
  def index
    if current_user
      @authentications = current_user.authentications
    end
  end
end
