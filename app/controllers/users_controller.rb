class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    check_user
    @user = User.find_by_id(params[:id])
    @admin_events = @user.admin_events
  end 

  def edit
    
  end

  def check_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
       redirect_to root_path
    end
  end

end
