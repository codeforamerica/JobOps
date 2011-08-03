class SettingsController < ApplicationController
  def index
     @user = User.find_by_id(current_user.id)
  end
end
