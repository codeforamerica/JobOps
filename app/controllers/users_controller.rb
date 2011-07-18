class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :template => 'users/profile/show'
  end
end
