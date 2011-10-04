class CommunitiesController < ApplicationController
  before_filter :authenticate_user!, :only => :twitter_follow

  def index
    if current_user
      @authentications = current_user.authentications
    end
  end

  def twitter_follow
    @twitter_client = current_user.twitter_user.follow(params[:id])

    message = {"message" => "#{@twitter_client.screen_name} followed." }
    respond_to do |format|
      format.json { render :json => message }
    end
  end



end
