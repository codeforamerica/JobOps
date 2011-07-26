class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def index
     @user = User.find_by_id(current_user.id)
  end

end
