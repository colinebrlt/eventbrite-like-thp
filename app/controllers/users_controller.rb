class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :check_user
  
  def show
    unless is_author?(@user)
      redirect_back(fallback_location: root_path)
    end
    @admin_events = current_user.admin_events
  end

  def edit
    unless is_author?(@user)
      redirect_to current_user, danger: "You can't edit an account that isn't yours"
    end
  end

  def update
    if is_author?(@user)
      if @user.update(user_params)
        redirect_to @user, success: "Your informations have been updated"
      else
        render :edit
      end
    else
      redirect_to user_path(params[:id]), danger: "You can't edit an account that isn't yours"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :avatar)
  end

  def check_user
    @user = User.find(params[:id])
  end
end