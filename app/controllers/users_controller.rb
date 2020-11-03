class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find_by_id(params[:id])
    @admin_events = @user.admin_events
  end 

  def create

  end 
end
